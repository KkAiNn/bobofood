import 'package:flutter/material.dart';
import 'package:bobofood/constants/index.dart';

/// 自定义单选按钮组件
class AppRadio extends StatelessWidget {
  /// 是否选中
  final bool value;

  /// 选中状态变化回调
  final ValueChanged<bool>? onChanged;

  /// 按钮大小
  final double? size;

  /// 激活颜色
  final Color? activeColor;

  /// 未激活颜色
  final Color? inactiveColor;

  /// 边框宽度
  final double borderWidth;

  /// 内部填充的比例，值越小内部圆点越小
  final double innerScale;

  /// 是否启用
  final bool enabled;

  /// 构造函数
  const AppRadio({
    super.key,
    required this.value,
    this.onChanged,
    this.size,
    this.activeColor,
    this.inactiveColor,
    this.borderWidth = 2.0,
    this.innerScale = 0.5,
    this.enabled = true,
  });

  Color getBorderColor() {
    if (enabled) {
      return value
          ? activeColor ?? AppColors.colors.background.primary
          : inactiveColor ?? AppColors.colors.bordersAndSeparators.defaultColor;
    }
    return AppColors.colors.background.disabled;
  }

  Color getActiveColor() {
    if (enabled) {
      return value
          ? activeColor ?? AppColors.colors.background.primary
          : inactiveColor ?? AppColors.colors.background.layer2Background;
    }
    return AppColors.colors.background.disabled;
  }

  Color getBackgroundColor() {
    return value
        ? AppColors.colors.background.elementBackground
        : enabled
            ? AppColors.colors.background.layer2Background
            : AppColors.colors.background.disabled;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled
          ? onChanged != null
              ? () => onChanged!(!value)
              : null
          : null,
      child: Container(
        width: size ?? 24.w,
        height: size ?? 24.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: getBackgroundColor(),
          border: Border.all(
            color: getBorderColor(),
            width: borderWidth,
          ),
        ),
        child: Center(
          child: value
              ? AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: (size ?? 24.w) * innerScale,
                  height: (size ?? 24.w) * innerScale,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: getActiveColor(),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

/// 带标签的单选按钮
class AppRadioWithLabel extends StatelessWidget {
  /// 是否选中
  final bool value;

  /// 选中状态变化回调
  final ValueChanged<bool>? onChanged;

  /// 标签文本
  final String label;

  /// 单选按钮大小
  final double size;

  /// 激活颜色
  final Color? activeColor;

  /// 标签文本样式
  final TextStyle? labelStyle;

  /// 间距
  final double spacing;

  /// 构造函数
  const AppRadioWithLabel({
    super.key,
    required this.value,
    required this.label,
    this.onChanged,
    this.size = 16.0,
    this.activeColor,
    this.labelStyle,
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppRadio(
              value: value,
              onChanged: onChanged,
              size: size,
              activeColor: activeColor),
          SizedBox(width: spacing),
          Text(label, style: labelStyle ?? TextStyle(fontSize: size * 0.8)),
        ],
      ),
    );
  }
}
