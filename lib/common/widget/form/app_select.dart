import 'package:bobofood/common/widget/app_svg.dart';
import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:bobofood/common/widget/tap_effect.dart';
import 'package:bobofood/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSelectInput extends StatefulWidget {
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
  final bool showArrowRight;
  final bool? required;

  const AppSelectInput({
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
    this.showArrowRight = true,
    this.required = false,
  });

  @override
  State<AppSelectInput> createState() => _AppSelectInputState();
}

class _AppSelectInputState extends State<AppSelectInput> {
  Widget _buildSuffixIcon() {
    if (!widget.showArrowRight) {
      return const SizedBox.shrink();
    }
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 16.w),
      width: 24.w,
      height: 24.w,
      child: AppSvg(
        path: 'assets/icons/Arrow right.svg',
        color: AppColors.colors.icon.light,
        width: 24.w,
        height: 24.w,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TapEffect(
        onTap: widget.onTap,
        child: AppInput(
          controller: widget.controller,
          hintText: widget.hintText ?? 'Enter password',
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: _buildSuffixIcon(),
          obscureText: false,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          maxLines: 1,
          enabled: false,
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
          required: widget.required,
        ));
  }
}
