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
  final bool ignorePointer;

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
    this.ignorePointer = false,
  });

  @override
  State<TapEffect> createState() => _TapEffectState();
}

class _TapEffectState extends State<TapEffect>
    with SingleTickerProviderStateMixin {
  double opacity = 1;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: widget.pressedOpacity,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _opacityAnimation.addListener(() {
      setState(() {
        opacity = _opacityAnimation.value;
      });
    });
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
    widget.onTapDown?.call(details);
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTapUp?.call(details);
  }

  void _handleTapCancel() {
    _controller.reverse();
    widget.onTapCancel?.call();
  }

  void _longPress() {
    feedBack();
    // 长按时不要恢复透明度，保持按下状态
    widget.onLongPress?.call();
    // 长按结束后延迟恢复透明度
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
        : IgnorePointer(
            ignoring: widget.ignorePointer,
            child: GestureDetector(
              onTap: widget.onTap,
              onLongPress: _longPress,
              onTapDown: _handleTapDown,
              onTapUp: _handleTapUp,
              onTapCancel: _handleTapCancel,
              child: AnimatedOpacity(
                opacity: opacity,
                duration: widget.duration,
                curve: Curves.easeInOut,
                child: widget.child,
              ),
            ),
          );

    return ClipRRect(borderRadius: radius, child: effectiveChild);
  }
}
