import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPasswordInput extends StatefulWidget {
  final AppInputController? controller;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final Color? fillColor;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? contentPadding;
  final bool showToggleButton; // 是否显示切换按钮
  final Widget? customVisibleIcon; // 自定义可见图标
  final Widget? customInvisibleIcon; // 自定义不可见图标

  const AppPasswordInput({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.focusNode,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.fillColor,
    this.borderRadius,
    this.borderColor,
    this.hintStyle,
    this.textStyle,
    this.contentPadding,
    this.showToggleButton = true,
    this.customVisibleIcon,
    this.customInvisibleIcon,
  });

  @override
  State<AppPasswordInput> createState() => _AppPasswordInputState();
}

class _AppPasswordInputState extends State<AppPasswordInput> {
  bool _obscureText = true; // 默认隐藏密码

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _buildSuffixIcon() {
    if (!widget.showToggleButton) {
      return const SizedBox.shrink();
    }

    return IconButton(
      icon: _obscureText
          ? (widget.customInvisibleIcon ??
              Icon(
                Icons.visibility_off,
                size: 20.w,
              ))
          : (widget.customVisibleIcon ??
              Icon(
                Icons.visibility,
                size: 20.w,
              )),
      onPressed: _toggleObscureText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppInput(
      controller: widget.controller,
      hintText: widget.hintText ?? 'Enter password',
      labelText: widget.labelText,
      prefixIcon: widget.prefixIcon,
      suffixIcon: _buildSuffixIcon(),
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      maxLines: 1,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      fillColor: widget.fillColor,
      borderRadius: widget.borderRadius,
      borderColor: widget.borderColor,
      hintStyle: widget.hintStyle,
      textStyle: widget.textStyle,
      contentPadding: widget.contentPadding,
    );
  }
}
