import 'dart:io';

import 'package:bobofood/constants/index.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'router/app_router.dart';
import 'services/storage_services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'global.dart';

void main() async {
  await Global.init();
  runApp(const MyApp());
  // runApp(
  //   DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Box setting = AppStorage.conifg;

    // 字体缩放大小
    double textScale = setting.get(
      ConifgBoxKey.defaultTextScale,
      defaultValue: 1.0,
    );

    // 强制设置高帧率
    if (Platform.isAndroid) {
      try {
        late List modes;
        FlutterDisplayMode.supported.then((value) {
          modes = value;
          var storageDisplay = setting.get(ConifgBoxKey.displayMode);
          DisplayMode f = DisplayMode.auto;
          if (storageDisplay != null) {
            f = modes.firstWhere((e) => e.toString() == storageDisplay);
          }
          DisplayMode preferred = modes.toList().firstWhere((el) => el == f);
          FlutterDisplayMode.setPreferredMode(preferred);
        });
      } catch (_) {}
    }
    return BuildMainApp(textScale: textScale);
  }
}

class BuildMainApp extends StatelessWidget {
  const BuildMainApp({super.key, required this.textScale});

  final double textScale;

  @override
  Widget build(BuildContext context) {
    final isDark = AppStorage.conifg.get(ConifgBoxKey.themeMode);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          // 禁止滚动拉伸
          scrollBehavior: AppScrollBehavior(),
          debugShowCheckedModeBanner: false,
          title: 'Bobo Food',
          themeMode: isDark == true ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: const Locale("zh", "CN"),
          supportedLocales: const [Locale("zh", "CN"), Locale("en", "US")],
          fallbackLocale: const Locale("zh", "CN"),
          getPages: Routes.getPages,
          initialRoute: Global.getInitRoute(),
          builder: (BuildContext context, Widget? child) {
            // 初始化主题颜色
            AppColors.initialize(context);
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.linear(textScale)),
              child: child!,
            );
          },
          onReady: () async {
            // Data.init();
            // setupServiceLocator();
          },
        );
      },
    );
  }
}
