import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<T?> showAppModalPage<T>(
  BuildContext context, {
  required Widget child,
  bool barrierDismissible = true,
  double? maxHeightFraction, // 如 0.9 表示最多占屏幕 90%
  BorderRadius? radius,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierLabel: 'AppModal',
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.black.withOpacity(0.3),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const SizedBox.shrink(); // 由 transitionBuilder 渲染
    },
    transitionBuilder: (context, animation, secondaryAnimation, _) {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );

      return ModalPageWrapper(
        animation: curvedAnimation,
        child: child,
        maxHeightFraction: maxHeightFraction,
        radius: radius,
      );
    },
  );
}

class ModalPageWrapper extends StatefulWidget {
  final Animation<double> animation;
  final Widget child;
  final double? maxHeightFraction;
  final BorderRadius? radius;

  const ModalPageWrapper({
    super.key,
    required this.animation,
    required this.child,
    this.maxHeightFraction,
    this.radius,
  });

  @override
  State<ModalPageWrapper> createState() => _ModalPageWrapperState();
}

class _ModalPageWrapperState extends State<ModalPageWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController dragController;
  double offsetY = 0.0;

  @override
  void initState() {
    super.initState();
    dragController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      offsetY += details.delta.dy;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (offsetY > 100 || details.primaryVelocity! > 500) {
      Navigator.of(context).pop();
    } else {
      dragController.forward(from: 0).whenComplete(() {
        setState(() {
          offsetY = 0;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final maxHeight = widget.maxHeightFraction != null
        ? screenHeight * widget.maxHeightFraction!
        : screenHeight;

    return Stack(
      children: [
        // 背景缩放效果
        Transform.scale(
          scale: 1.0 - widget.animation.value * 0.05,
          child: Opacity(
            opacity: 0.95,
            child: AbsorbPointer(
              absorbing: true,
              child: const ColoredBox(color: Colors.black12),
            ),
          ),
        ),
        // 弹窗内容
        Positioned(
          bottom: -offsetY,
          left: 0,
          right: 0,
          child: GestureDetector(
            onVerticalDragUpdate: _onVerticalDragUpdate,
            onVerticalDragEnd: _onVerticalDragEnd,
            child: AnimatedBuilder(
              animation: widget.animation,
              builder: (context, child) {
                return SlideTransition(
                  position:
                      Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                          .animate(widget.animation),
                  child: Material(
                    color: Colors.white,
                    borderRadius: widget.radius ??
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: maxHeight),
                      child: SafeArea(child: widget.child),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    dragController.dispose();
    super.dispose();
  }
}
