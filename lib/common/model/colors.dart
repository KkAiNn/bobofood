import 'dart:ui';
import 'package:flutter/material.dart';

class PrimaryColors {
  Color main;
  Color primary100;
  Color primary200;
  Color primary300;
  Color primary400;
  Color primary500;
  Color primary600;
  Color primary700;
  PrimaryColors(this.main, this.primary100, this.primary200, this.primary300,
      this.primary400, this.primary500, this.primary600, this.primary700);
}

class TypographyColors {
  Color main;
  Color typography100;
  Color typography200;
  Color typography300;
  Color typography400;
  Color typography500;
  TypographyColors(this.main, this.typography100, this.typography200,
      this.typography300, this.typography400, this.typography500);
}

class GreyColors {
  Color grey0;
  Color grey50;
  Color grey100;
  Color grey200;
  Color grey300;
  Color grey400;
  Color grey500;
  Color grey600;
  Color grey700;
  GreyColors(this.grey0, this.grey50, this.grey100, this.grey200, this.grey300,
      this.grey400, this.grey500, this.grey600, this.grey700);
}

class OtherColors {
  Color red;
  Color yellow;
  Color blue;
  Color green;
  Color orange;
  Color lightRed;
  OtherColors(
      this.red, this.yellow, this.blue, this.green, this.orange, this.lightRed);
}

class TransparentColors {
  Color transparentGrey500;
  Color transparentGrey0;
  Color transparentPrimary600;
  Color transparentBackgroundblur;
  TransparentColors(this.transparentGrey500, this.transparentGrey0,
      this.transparentPrimary600, this.transparentBackgroundblur);
}

class GradientColors {
  Color gradientLight;
  Color gradientDark;
  LinearGradient linear;
  GradientColors(this.gradientLight, this.gradientDark, this.linear);
}

class BaseColors {
  Color white;
  Color black;
  BaseColors(this.white, this.black);
}

class BackgroundColors {
  Color primary;
  Color secondary;
  Color danger;
  Color lightRed;
  Color grey;
  Color disabled;
  Color surfaceBackground;
  Color elementBackground;
  Color layer1Background;
  Color layer2Background;
  Color layer3Background;
  Color backgroundBlur;
  Color transparentNav;
  Color darkModeDarkest;

  BackgroundColors(
      {required this.primary,
      required this.secondary,
      required this.danger,
      required this.lightRed,
      required this.grey,
      required this.disabled,
      required this.surfaceBackground,
      required this.elementBackground,
      required this.layer1Background,
      required this.layer2Background,
      required this.layer3Background,
      required this.backgroundBlur,
      required this.transparentNav,
      required this.darkModeDarkest});
}

class TypographyColors2 {
  Color heading;
  Color paragraph;
  Color lightGrey;
  Color inactive;
  Color disabled;
  Color primary;
  Color primary700;
  Color white;
  Color danger;
  TypographyColors2(
      {required this.heading,
      required this.paragraph,
      required this.lightGrey,
      required this.inactive,
      required this.disabled,
      required this.primary,
      required this.primary700,
      required this.white,
      required this.danger});
}

class IconColors {
  Color defaultColor;
  Color light;
  Color disabled;
  Color primary;
  Color white;
  Color red;
  Color yellow;
  Color blue;
  Color orange;
  Color dark;

  IconColors(
      {required this.defaultColor,
      required this.light,
      required this.disabled,
      required this.primary,
      required this.white,
      required this.red,
      required this.yellow,
      required this.blue,
      required this.orange,
      required this.dark});
}

class BordersAndSeparatorsColors {
  Color defaultColor;
  Color light;
  Color primary;
  Color white;
  Color red;
  Color dark;
  Color link;
  Color transparentGrey;
  Color transparentPrimary;

  BordersAndSeparatorsColors(
      {required this.defaultColor,
      required this.light,
      required this.primary,
      required this.white,
      required this.red,
      required this.dark,
      required this.link,
      required this.transparentGrey,
      required this.transparentPrimary});
}

class IllustrationColors {
  Color greyLightest;
  Color grey;
  Color greyDark;

  IllustrationColors(
      {required this.greyLightest, required this.grey, required this.greyDark});
}

class GradientColors2 {
  Color light;
  Color dark;
  GradientColors2(this.light, this.dark);
}

class LogoColors {
  Color primary;
  Color black;
  LogoColors(this.primary, this.black);
}

class ColorStyleModel {
  BackgroundColors background;
  TypographyColors2 typography;
  IconColors icon;
  BordersAndSeparatorsColors bordersAndSeparators;
  IllustrationColors illustration;
  GradientColors2 gradient;
  LogoColors logo;
  ColorStyleModel(
      {required this.background,
      required this.typography,
      required this.icon,
      required this.bordersAndSeparators,
      required this.illustration,
      required this.gradient,
      required this.logo});
}
