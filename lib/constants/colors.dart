import 'package:bobofood/common/model/colors.dart';
import 'package:bobofood/services/storage_services.dart';
import 'package:flutter/material.dart';

class AppColors {
  // 主色调
  static late PrimaryColors primary;
  static late TypographyColors typography;
  static late GreyColors grey;
  static late OtherColors other;
  static late TransparentColors transparent;
  static late GradientColors gradient;
  static late BaseColors base;
  static late BaseColors theme;

  static late ColorStyleModel colors;
  static bool _initialized = false;

  // 私有构造函数
  AppColors._();

  // 初始化颜色
  static void initialize(BuildContext context) {
    if (_initialized) return;

    final isDark =
        AppStorage.conifg.get(ConifgBoxKey.themeMode, defaultValue: false);
    toggleTheme(isDark);

    _initialized = true;
  }

  // 切换主题
  static void toggleTheme(bool isDarkMode) {
    if (isDarkMode) {
      initDarkTheme();
    } else {
      initLightTheme();
    }
    colors = ColorStyleModel(
      background: BackgroundColors(
        primary: primary.primary600,
        secondary: primary.primary100,
        danger: other.red,
        lightRed: other.lightRed,
        grey: grey.grey500,
        disabled: grey.grey200,
        surfaceBackground: grey.grey0,
        elementBackground: grey.grey0,
        layer1Background: grey.grey50,
        layer2Background: grey.grey100,
        layer3Background: grey.grey200,
        backgroundBlur: transparent.transparentBackgroundblur,
        transparentNav: grey.grey0,
        darkModeDarkest: base.black,
      ),
      typography: TypographyColors2(
          heading: typography.typography500,
          paragraph: typography.typography400,
          lightGrey: typography.typography300,
          inactive: typography.typography200,
          disabled: typography.typography100,
          primary: primary.primary600,
          primary700: primary.primary700,
          white: base.white,
          danger: other.red),
      icon: IconColors(
          defaultColor: grey.grey600,
          light: grey.grey400,
          disabled: grey.grey400,
          primary: primary.primary600,
          white: base.white,
          red: other.red,
          yellow: other.yellow,
          blue: other.blue,
          orange: other.orange,
          dark: grey.grey700),
      bordersAndSeparators: BordersAndSeparatorsColors(
          defaultColor: grey.grey200,
          light: grey.grey100,
          primary: primary.primary600,
          white: grey.grey0,
          red: other.red,
          dark: grey.grey600,
          link: other.blue,
          transparentGrey: transparent.transparentGrey500,
          transparentPrimary: transparent.transparentPrimary600),
      illustration: IllustrationColors(
          greyLightest: grey.grey500,
          grey: grey.grey500,
          greyDark: grey.grey700),
      gradient: GradientColors2(gradient.gradientLight, gradient.gradientDark),
      logo: LogoColors(primary.primary600, typography.typography500),
    );
  }

  static void initDarkTheme() {
    // 主色调
    Color primary100 = Color(0xFF3B3F38);
    Color primary200 = Color(0xFF3E532D);
    Color primary300 = Color(0xFF436923);
    Color primary400 = Color(0xFF5D9E26);
    Color primary500 = Color(0xFF6CB231);
    Color primary600 = Color(0xFF70BA32);
    Color primary700 = Color(0xFF88CD4E);
    // primary = primary500; // 更改为 primary500 的值作为主色

    primary = PrimaryColors(
      primary500,
      primary100,
      primary200,
      primary300,
      primary400,
      primary500,
      primary600,
      primary700,
    );

    Color typography100 = Color(0xFF7F7F7E);
    Color typography200 = Color(0xFF888A87);
    Color typography300 = Color(0xFF9FA19E);
    Color typography400 = Color(0xFFC8C9C7);
    Color typography500 = Color(0xFFEEF0ED);
    typography = TypographyColors(
      typography500,
      typography100,
      typography200,
      typography300,
      typography400,
      typography500,
    );

    Color grey0 = Color(0xFF262725);
    Color grey50 = Color(0xFF2D2E2C);
    Color grey100 = Color(0xFF313330);
    Color grey200 = Color(0xFF3D3D3D);
    Color grey300 = Color(0xFF7A7A79);
    Color grey400 = Color(0xFF989998);
    Color grey500 = Color(0xFFD5D6D3);
    Color grey600 = Color(0xFFf4f7f2);
    Color grey700 = Color(0xFFF9FAF8);
    grey = GreyColors(
      grey0,
      grey50,
      grey100,
      grey200,
      grey300,
      grey400,
      grey500,
      grey600,
      grey700,
    );

    Color red = Color(0xFFFB6A57);
    Color yellow = Color(0xFFFBB650);
    Color blue = Color(0xFF6FBDCE);
    Color green = Color(0xFF8CEC7D);
    Color orange = Color(0xFFE48047);
    Color lightRed = Color(0xFFfef5f3);
    other = OtherColors(
      red,
      yellow,
      blue,
      green,
      orange,
      lightRed,
    );

    Color transparentGrey500 = Color(0xFFD5D6D3);
    Color transparentGrey0 = Color(0xFF262725);
    Color transparentPrimary600 = Color(0xFF70BA32);
    Color transparentBackgroundblur = Color(0xFF262725);
    transparent = TransparentColors(
      transparentGrey500,
      transparentGrey0,
      transparentPrimary600,
      transparentBackgroundblur,
    );

    Color gradientLight = Color(0xFF6CB231);
    Color gradientDark = Color(0xFF6CB231);
    LinearGradient linear =
        LinearGradient(colors: [gradientLight, gradientDark]);
    gradient = GradientColors(gradientLight, gradientDark, linear);

    Color white = Color(0xFFFFFFFF);
    Color black = Color(0xFF040404);
    base = BaseColors(
      white,
      black,
    );
    theme = BaseColors(
      black,
      white,
    );
  }

  static void initLightTheme() {
    // 主色调
    Color primary100 = Color(0xFFECF1E8);
    Color primary200 = Color(0xFFDDEFCE);
    Color primary300 = Color(0xFFB7EC8C);
    Color primary400 = Color(0xFF8BDE47);
    Color primary500 = Color(0xFF67BD1F);
    Color primary600 = Color(0xFF54A312);
    Color primary700 = Color(0xFF408308);
    primary = PrimaryColors(
      primary500,
      primary100,
      primary200,
      primary300,
      primary400,
      primary500,
      primary600,
      primary700,
    );
    Color typography100 = Color(0xFFB6B8B5);
    Color typography200 = Color(0xFF91958E);
    Color typography300 = Color(0xFF70756B);
    Color typography400 = Color(0xFF60655C);
    Color typography500 = Color(0xFF363A33);
    typography = TypographyColors(
      typography500,
      typography100,
      typography200,
      typography300,
      typography400,
      typography500,
    );

    Color grey0 = Color(0xFFFFFFFF);
    Color grey50 = Color(0xFFF9FAF8);
    Color grey100 = Color(0xFFF4F7F2);
    Color grey200 = Color(0xFFE8EBE6);
    Color grey300 = Color(0xFFA9ADA5);
    Color grey400 = Color(0xFF91958E);
    Color grey500 = Color(0xFF60635E);
    Color grey600 = Color(0xFF60635e);
    Color grey700 = Color(0xFF363a33);
    grey = GreyColors(
      grey0,
      grey50,
      grey100,
      grey200,
      grey300,
      grey400,
      grey500,
      grey600,
      grey700,
    );

    Color red = Color(0xFFE25839);
    Color yellow = Color(0xFFF5AE42);
    Color blue = Color(0xFF24B5D4);
    Color green = Color(0xFF45B733);
    Color orange = Color(0xFFE8712E);
    Color lightRed = Color(0xFFfef5f3);
    other = OtherColors(
      red,
      yellow,
      blue,
      green,
      orange,
      lightRed,
    );

    Color transparentGrey500 = Color(0xFF60635E);
    Color transparentGrey0 = Color(0xFFFFFFFF);
    Color transparentPrimary600 = Color(0xFF54A312);
    Color transparentBackgroundblur = Color(0xFF9FA19E);
    transparent = TransparentColors(
      transparentGrey500,
      transparentGrey0,
      transparentPrimary600,
      transparentBackgroundblur,
    );

    Color gradientLight = Color(0xFF5EAD1D);
    Color gradientDark = Color(0xFF54A312);
    LinearGradient linear =
        LinearGradient(colors: [gradientLight, gradientDark]);
    gradient = GradientColors(
      gradientLight,
      gradientDark,
      linear,
    );

    Color white = Color(0xFFFFFFFF);
    Color black = Color(0xFFF0EFED);
    base = BaseColors(
      white,
      black,
    );

    theme = BaseColors(
      white,
      Color(0xFF040404),
    );
  }
}
