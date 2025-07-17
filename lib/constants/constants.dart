import 'package:bobofood/services/storage_services.dart';

class AppConstants {
  static const String appLogoLight = 'assets/images/logo.png';
  static const String appLogoDark = 'assets/images/logo_dark.png';
  static String get appLogo => () {
        final isDark =
            AppStorage.conifg.get(ConifgBoxKey.themeMode, defaultValue: false);
        return isDark ? appLogoDark : appLogoLight;
      }();

  static const emptyDark = 'assets/Illustrations/Empty state - dark mode.png';
  static const emptyLight = 'assets/Illustrations/Empty state - light mode.png';
  static String get emptyImg => () {
        final isDark =
            AppStorage.conifg.get(ConifgBoxKey.themeMode, defaultValue: false);
        return isDark ? emptyDark : emptyLight;
      }();
}
