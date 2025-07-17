import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppModal {
  static Future<T?> show<T>({
    required Widget child,
    bool isScrollControlled = true,
    bool enableDrag = true,
    bool useRootNavigator = true,
    bool dismissible = true,
    double radius = 16,
    Color? backgroundColor,
  }) {
    return showModalBottomSheet<T>(
      context: Get.context!,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      enableDrag: enableDrag,
      isDismissible: dismissible,
      backgroundColor: backgroundColor ?? Colors.transparent,
      builder: (context) {
        return _AppModalWrapper(
          radius: radius,
          child: child,
        );
      },
    );
  }
}

class _AppModalWrapper extends StatelessWidget {
  final double radius;
  final Widget child;

  const _AppModalWrapper({
    required this.radius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
        child: Material(
          color: Colors.white,
          child: SafeArea(
            top: false,
            child: child,
          ),
        ),
      ),
    );
  }
}
