import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInputController extends TextEditingController {
  final ValueNotifier<bool> hasError = ValueNotifier(false);

  /// 外部传入的值变化回调
  VoidCallback? onTextChanged;

  final String? initialValue;

  AppInputController({this.onTextChanged, this.initialValue}) {
    addListener(() {
      onTextChanged?.call();
    });
    if (initialValue != null) {
      text = initialValue!;
    }
  }

  void setError([bool value = true]) {
    hasError.value = value;
  }

  void clearError() {
    hasError.value = false;
  }

  @override
  void dispose() {
    hasError.dispose();
    super.dispose();
  }
}

class AppInput extends StatefulWidget {
  final AppInputController? controller;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
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
  final TextStyle? disabledTextStyle;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign? textAlign;
  final bool? required;

  final Key? formFieldKey;
  const AppInput({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
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
    this.disabledTextStyle,
    this.contentPadding,
    this.textAlign,
    this.formFieldKey,
    this.required = false,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool _hasError = false;
  late final ValueNotifier<bool>? _errorNotifier;

  @override
  void initState() {
    super.initState();
    _errorNotifier = widget.controller?.hasError;
    _errorNotifier?.addListener(_onErrorChanged);
  }

  @override
  void didUpdateWidget(AppInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _errorNotifier?.removeListener(_onErrorChanged);
      _errorNotifier = widget.controller?.hasError;
      _errorNotifier?.addListener(_onErrorChanged);
    }
  }

  void _onErrorChanged() {
    if (_errorNotifier != null && _hasError != _errorNotifier.value) {
      setState(() {
        _hasError = _errorNotifier.value;
      });
    }
  }

  @override
  void dispose() {
    _errorNotifier?.removeListener(_onErrorChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? validator(String? value) {
      if (widget.required == true && (value == null || value.isEmpty)) {
        return 'This field is required';
      }
      final result = widget.validator?.call(value);
      return result;
    }

    final isMultiline = widget.minLines != null && widget.minLines! > 1;
    return SizedBox(
      height: isMultiline ? null : 48.h,
      child: TextFormField(
        key: widget.formFieldKey, // ✅ 只绑定外部传入的 key
        textAlign: widget.textAlign ?? TextAlign.start,
        controller: widget.controller,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        maxLines: isMultiline ? null : widget.maxLines,
        minLines: isMultiline ? widget.minLines : null,
        maxLength: widget.maxLength,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
        onSaved: (value) => widget.onSubmitted?.call(value ?? ''),
        inputFormatters: widget.inputFormatters,
        style: widget.enabled
            ? (widget.textStyle ?? AppTextStyle.poppinMedium400()).copyWith(
                color: _hasError
                    ? AppColors.colors.typography.danger
                    : AppColors.colors.typography.heading,
              )
            : (widget.disabledTextStyle ??
                (widget.textStyle ?? AppTextStyle.poppinMedium400()).copyWith(
                  color: _hasError
                      ? AppColors.colors.typography.danger
                      : AppColors.colors.typography.heading,
                )),
        validator: (value) {
          final result = validator(value);
          final isError = result != null;
          if (isError && widget.controller?.hasError.value == false) {
            widget.controller?.setError(isError);
          } else if (!isError && widget.controller?.hasError.value == true) {
            widget.controller?.clearError();
          }
          return result;
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintStyle != null
              ? widget.hintStyle?.copyWith(
                  color: _hasError
                      ? AppColors.colors.typography.danger
                      : widget.hintStyle?.color,
                )
              : AppTextStyle.poppinMedium400(
                  color: _hasError
                      ? AppColors.colors.typography.danger
                      : AppColors.colors.typography.inactive,
                ),
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          iconColor: _hasError
              ? AppColors.colors.typography.danger
              : AppColors.colors.icon.defaultColor,
          filled: true,
          fillColor: _hasError
              ? AppColors.colors.background.danger.withValues(alpha: 0.1)
              : widget.fillColor ??
                  AppColors.colors.background.elementBackground,
          contentPadding: widget.contentPadding ??
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          errorMaxLines: 2,
          border: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: AppColors.colors.bordersAndSeparators.defaultColor,
              width: 1.w,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: AppColors.colors.bordersAndSeparators.defaultColor,
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: AppColors.colors.bordersAndSeparators.primary,
              width: 2.w,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
              borderSide: BorderSide.none),
          errorStyle: AppTextStyle.poppinMedium400(
            color: AppColors.colors.typography.danger,
          ),
        ),
      ),
    );
  }
}
