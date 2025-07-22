import 'dart:async';
import 'dart:io';

import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:bobofood/common/model/localtion.dart';
import 'package:bobofood/constants/amap.dart';
import 'package:bobofood/utils/logger.dart';
import 'package:bobofood/utils/platformutils.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationUtils {
  // 单例实例
  static LocationUtils? _instance;

  // 获取单例实例的方法
  static LocationUtils get instance {
    _instance ??= LocationUtils._();
    return _instance!;
  }

  // 私有构造函数，防止外部实例化
  LocationUtils._();

  final AMapFlutterLocation _locationPlugin = AMapFlutterLocation();
  StreamSubscription<Map<String, Object>>? _locationListener;
  bool _isInitialized = false;
  bool onceLocation = false;

  Function(LocationModel)? onLocationChanged;

  Future<void> init() async {
    if (_isInitialized) return;

    /// 设置是否已经包含高德隐私政策并弹窗展示显示用户查看，如果未包含或者没有弹窗展示，高德定位SDK将不会工作
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    /// <b>必须保证在调用定位功能之前调用， 建议首次启动App时弹出《隐私政策》并取得用户同意</b>
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    ///
    /// [hasContains] 隐私声明中是否包含高德隐私政策说明
    ///
    /// [hasShow] 隐私权政策是否弹窗展示告知用户
    AMapFlutterLocation.updatePrivacyShow(true, true);

    /// 设置是否已经取得用户同意，如果未取得用户同意，高德定位SDK将不会工作
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    ///
    /// <b>必须保证在调用定位功能之前调用, 建议首次启动App时弹出《隐私政策》并取得用户同意</b>
    ///
    /// [hasAgree] 隐私权政策是否已经取得用户同意
    AMapFlutterLocation.updatePrivacyAgree(true);

    /// 动态申请定位权限
    await requestPermission();

    ///设置Android和iOS的apiKey<br>
    ///key的申请请参考高德开放平台官网说明<br>
    ///Android: https://lbs.amap.com/api/android-location-sdk/guide/create-project/get-key
    ///iOS: https://lbs.amap.com/api/ios-location-sdk/guide/create-project/get-key
    AMapFlutterLocation.setApiKey(AmapConfig.androidKey, AmapConfig.iosKey);

    ///iOS 获取native精度类型
    if (Platform.isIOS) {
      requestAccuracyAuthorization();
    }

    ///移除定位监听
    if (null != _locationListener) {
      _locationListener?.cancel();
    }

    ///注册定位结果监听
    _locationListener = _locationPlugin.onLocationChanged().listen(
      (result) {
        if (onceLocation) {
          stopListener();
        }
        logger.d('onLocationChanged: $result');
        onLocationChanged?.call(LocationModel.fromJson(result));
      },
      onError: (error) {
        logger.d('onError: $error');
      },
      onDone: () {
        logger.d('onDone');
      },
    );
    _isInitialized = true;
    getCurrentPosition();
  }

  /// 获取一次当前位置（带权限处理）
  Future<LocationModel?> getCurrentPosition({
    AMapLocationMode mode = AMapLocationMode.Hight_Accuracy,
    bool needAddress = false,
  }) async {
    // 模拟器不使用高精度定位
    if (PlatformUtils().isEmulator) {
      mode = AMapLocationMode.Device_Sensors;
    }
    await init(); // 防止未初始化
    final completer = Completer<LocationModel?>();
    onceLocation = true;

    onLocationChanged = (LocationModel result) {
      completer.complete(result);
    };

    _setLocationOption(mode: mode, needAddress: needAddress);
    _locationPlugin.startLocation();

    // 可选：超时处理，防止一直卡住
    Future.delayed(const Duration(seconds: 10), () {
      if (!completer.isCompleted) {
        completer.complete(null); // 或者你可以抛异常
      }
    });

    return completer.future;
  }

  /// 获取快速定位和精准定位 先获取手机定位，再获取精准定位 更好的用户体验
  Future<void> getFastThenAccuratePosition(
    Function(LocationModel) onSuccess,
  ) async {
    try {
      final position1 = await getCurrentPosition(
        mode: AMapLocationMode.Device_Sensors,
        needAddress: false,
      );
      if (position1 != null) {
        onSuccess(position1);
      }
      final position2 = await getCurrentPosition(
        mode: AMapLocationMode.Hight_Accuracy,
        needAddress: true,
      );
      if (position2 != null) {
        onSuccess(position2);
      }
    } catch (e) {
      logger.d('getFastThenAccuratePosition error: $e');
    }
  }

  ///设置定位参数
  void _setLocationOption({
    AMapLocationMode mode = AMapLocationMode.Hight_Accuracy,
    bool needAddress = false,
  }) {
    AMapLocationOption locationOption = AMapLocationOption();

    ///是否单次定位
    locationOption.onceLocation = onceLocation;

    ///是否需要返回逆地理信息
    locationOption.needAddress = needAddress;

    ///逆地理信息的语言类型
    locationOption.geoLanguage = GeoLanguage.DEFAULT;

    locationOption.desiredLocationAccuracyAuthorizationMode =
        AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

    locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

    ///设置Android端连续定位的定位间隔
    locationOption.locationInterval = 2000;

    ///设置Android端的定位模式<br>
    ///可选值：<br>
    ///<li>[AMapLocationMode.Battery_Saving]</li>
    ///<li>[AMapLocationMode.Device_Sensors]</li>
    ///<li>[AMapLocationMode.Hight_Accuracy]</li>
    locationOption.locationMode = mode;

    ///设置iOS端的定位最小更新距离<br>
    locationOption.distanceFilter = -1;

    ///设置iOS端期望的定位精度
    /// 可选值：<br>
    /// <li>[DesiredAccuracy.Best] 最高精度</li>
    /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
    /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
    /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
    /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
    locationOption.desiredAccuracy = DesiredAccuracy.Best;

    ///设置iOS端是否允许系统暂停定位
    locationOption.pausesLocationUpdatesAutomatically = false;

    ///将定位参数设置给定位插件
    _locationPlugin.setLocationOption(locationOption);
  }

  void startListener() {
    onceLocation = false;
    startLocation();
  }

  void stopListener() {
    _locationPlugin.stopLocation();
  }

  void startLocation() {
    init(); // 防止未初始化
    _setLocationOption();
    _locationPlugin.startLocation();
  }

  void dispose() {
    ///移除定位监听
    if (null != _locationListener) {
      _locationListener?.cancel();
    }

    ///销毁定位
    _locationPlugin.destroy();
    _isInitialized = false;
  }

  ///获取iOS native的accuracyAuthorization类型
  Future<void> requestAccuracyAuthorization() async {
    AMapAccuracyAuthorization currentAccuracyAuthorization =
        await _locationPlugin.getSystemAccuracyAuthorization();
    if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy) {
      logger.d("精确定位类型");
    } else if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationReducedAccuracy) {
      logger.d("模糊定位类型");
    } else {
      logger.d("未知定位类型");
    }
  }

  /// 动态申请定位权限
  Future<void> requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      logger.d("定位权限申请通过");
    } else {
      logger.d("定位权限申请不通过");
    }
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
