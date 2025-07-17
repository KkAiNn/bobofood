import 'package:bobofood/common/hooks/countdown_controller.dart';
import 'package:bobofood/common/widget/app_text.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:flutter/material.dart';

class VerifyCodeButton extends StatefulWidget {
  final CountdownController controller;
  final VoidCallback onPressed;

  final Widget? child;

  final Function(String text)? buildChild;

  const VerifyCodeButton({
    super.key,
    required this.controller,
    required this.onPressed,
    this.child,
    this.buildChild,
  });

  @override
  State<VerifyCodeButton> createState() => _VerifyCodeButtonState();
}

class _VerifyCodeButtonState extends State<VerifyCodeButton> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onUpdate);
  }

  void _onUpdate() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TapEffect(
      onTap: () {
        if (widget.controller.isRunning) {
          return;
        }
        widget.controller.start();
        widget.onPressed(); // 发验证码逻辑
      },
      child: widget.buildChild != null
          ? widget.buildChild!(widget.controller.displayText)
          : widget.child ?? AppText(widget.controller.displayText),
    );
  }
}
