import 'package:flutter/material.dart';
import 'package:bobofood/utils/feed_back.dart';

class TapEffect extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Duration duration;
  final double pressedOpacity;
  final bool enableRipple;
  final BorderRadius? borderRadius;
  final Color? splashColor;
  final Color? bgColor;
  final void Function(TapDownDetails)? onTapDown;
  final void Function()? onTapCancel;
  final void Function(TapUpDetails)? onTapUp;
  final void Function(DragUpdateDetails)? onPanUpdate;
  final void Function(DragEndDetails)? onPanEnd;
  final void Function(DragStartDetails)? onPanStart;
  final void Function()? onPanCancel;
  final void Function(DragDownDetails)? onPanDown;

  const TapEffect({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.duration = const Duration(milliseconds: 100),
    this.pressedOpacity = 0.5,
    this.enableRipple = false,
    this.borderRadius,
    this.splashColor,
    this.bgColor,
    this.onTapDown,
    this.onTapCancel,
    this.onTapUp,
    this.onPanUpdate,
    this.onPanEnd,
    this.onPanStart,
    this.onPanCancel,
    this.onPanDown,
  });

  @override
  State<TapEffect> createState() => _TapEffectState();
}

class _TapEffectState extends State<TapEffect>
    with SingleTickerProviderStateMixin {
  double opacity = 1;

  @override
  void initState() {
    super.initState();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      opacity = .5;
    });
    widget.onTapDown?.call(details);
  }

  void _handleTapCancel() {
    setState(() {
      opacity = 1;
    });
    widget.onTapCancel?.call();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      opacity = 1;
    });
    widget.onTapUp?.call(details);
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    widget.onPanUpdate?.call(details);
  }

  void _handlePanDown(DragDownDetails details) {
    widget.onPanDown?.call(details);
  }

  void _handlePanStart(DragStartDetails details) {
    widget.onPanStart?.call(details);
  }

  void _handlePanEnd(DragEndDetails details) {
    widget.onPanEnd?.call(details);
  }

  void _handlePanCancel() {
    widget.onPanCancel?.call();
  }

  void _longPress() {
    feedBack();
    setState(() {
      opacity = .5;
    });
    widget.onLongPress?.call();
  }

  void _longPressEnd(LongPressEndDetails details) {
    setState(() {
      opacity = 1;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadius ?? BorderRadius.zero;

    Widget effectiveChild = widget.enableRipple
        ? Material(
            color: widget.bgColor ?? Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              onLongPress: _longPress,
              onTapDown: _handleTapDown,
              onTapCancel: _handleTapCancel,
              onTapUp: _handleTapUp,
              borderRadius: radius,
              splashColor: widget.splashColor,
              highlightColor: widget.splashColor,
              child: widget.child,
            ),
          )
        : GestureDetector(
            onTap: widget.onTap,
            onLongPress: _longPress,
            onTapDown: _handleTapDown,
            onTapCancel: _handleTapCancel,
            onTapUp: _handleTapUp,
            onPanDown: _handlePanDown,
            onPanStart: _handlePanStart,
            onPanEnd: _handlePanEnd,
            onPanCancel: _handlePanCancel,
            onPanUpdate: _handlePanUpdate,
            onLongPressEnd: _longPressEnd,
            child: AnimatedOpacity(
              opacity: opacity,
              duration: widget.duration,
              curve: Curves.easeInOut,
              child: widget.child,
            ),
          );

    return ClipRRect(borderRadius: radius, child: effectiveChild);
  }
}
