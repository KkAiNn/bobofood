import 'package:bobofood/constants/index.dart';
import 'package:bobofood/services/storage_services.dart';
import 'package:bobofood/utils/app_event_bus.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final _isDark = false.obs;

  bool get isDark => _isDark.value;

  void toggleTheme() {
    _isDark.value = !_isDark.value;
    if (_isDark.value) {
      Get.changeTheme(AppTheme.dark);
    } else {
      Get.changeTheme(AppTheme.light);
    }
    AppStorage.conifg.put(ConifgBoxKey.themeMode, _isDark.value);
    AppColors.toggleTheme(_isDark.value);
    appEventBus.fire(ThemeChangedEvent());
  }

  @override
  void onInit() {
    super.onInit();
    final themeMode = AppStorage.conifg.get(ConifgBoxKey.themeMode);
    if (themeMode == true) {
      setDark(true);
    }
  }

  void setDark(bool value) {
    _isDark.value = value;
    // Get.changeTheme(value ? AppTheme.dark : AppTheme.light);
  }
}
