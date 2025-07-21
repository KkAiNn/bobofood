import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';

class AppBadge extends StatelessWidget {
  final Widget? child;

  /// 数字内容，null 表示纯红点
  final int? count;

  /// 是否显示角标
  final bool show;

  /// 角标颜色
  final Color? badgeColor;

  /// 最大数字（超过显示 `99+`）
  final int maxCount;

  /// 显示的偏移
  final double? top;
  final double? right;

  /// 纯红点大小（没有 count 时）
  final double dotSize;

  const AppBadge({
    super.key,
    this.child,
    this.count,
    this.show = true,
    this.badgeColor,
    this.maxCount = 99,
    this.top,
    this.right,
    this.dotSize = 8.0,
  });

  String? get _displayText {
    if (count == null || count! <= 0) return null;
    if (count! > maxCount) return "$maxCount+";
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    final badge = _buildBadge();

    if (child == null) {
      // 没有 child，独立展示角标
      return Visibility(visible: show, child: badge);
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child!,
        if (show) Positioned(top: top ?? -2, right: right ?? -2, child: badge),
      ],
    );
  }

  Widget _buildBadge() {
    final text = _displayText;
    final color = badgeColor ?? AppColors.colors.icon.red;

    if (text == null) {
      // 纯红点
      return Container(
        width: dotSize,
        height: dotSize,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      constraints: const BoxConstraints(minHeight: 16),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 10),
        textAlign: TextAlign.center,
      ),
    );
  }
}
