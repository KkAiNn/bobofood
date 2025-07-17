import 'package:flutter/material.dart';

/// 颜色工具类扩展
extension ColorExtension on Color {
  /// 创建一个带有指定透明度的颜色
  /// [alpha] 透明度值，0-255之间
  Color withValues({int? red, int? green, int? blue, int? alpha}) {
    return Color.fromARGB(
      alpha ?? this.alpha,
      red ?? this.red,
      green ?? this.green,
      blue ?? this.blue,
    );
  }
}
