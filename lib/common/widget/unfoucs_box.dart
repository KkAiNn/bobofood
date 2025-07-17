import 'package:flutter/material.dart';

/// 点击空白处收起键盘
class UnfoucsBox extends StatelessWidget {
  const UnfoucsBox({
    super.key,
    required this.child,
    this.onTap,
    this.onPanDown,
  });

  final Widget child;

  final void Function()? onTap;
  final void Function()? onPanDown;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (details) {
        onPanDown?.call();
        FocusScope.of(context).unfocus();
      },
      onTap: () {
        onTap?.call();
      },
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}
