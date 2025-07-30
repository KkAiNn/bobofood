import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppSearchInput extends StatefulWidget {
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

  const AppSearchInput({
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
  State<AppSearchInput> createState() => _AppSearchInputState();
}

class _AppSearchInputState extends State<AppSearchInput> {
  @override
  Widget build(BuildContext context) {
    return AppInput(
      controller: widget.controller,
      hintText: widget.hintText ?? 'Enter password',
      labelText: widget.labelText,
      prefixIcon: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 4.w, 12.h),
        child: AppSvg(
          path: 'assets/icons/Search.svg',
          color: AppColors.colors.icon.light,
          width: 24.w,
          height: 24.w,
        ),
      ),
      obscureText: false,
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
