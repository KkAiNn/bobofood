import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomVerificationCode extends StatefulWidget {
  /// 验证码长度
  final int length;

  /// 输入完成回调
  final Function(String) onCompleted;

  /// 输入变化回调
  final Function(String)? onChanged;

  /// 验证器
  final String? Function(String?)? validator;

  /// 是否自动获取焦点
  final bool autoFocus;

  /// 输入框宽度
  final double? width;

  /// 输入框高度
  final double? height;

  /// 输入框之间的间距
  final double? spacing;

  /// 是否自适应宽度
  final bool isAutoWidth;

  /// 默认边框颜色
  final Color? borderColor;

  /// 焦点边框颜色
  final Color? focusedBorderColor;

  /// 已填充边框颜色
  final Color? filledBorderColor;

  /// 错误边框颜色
  final Color? errorBorderColor;

  /// 文本样式
  final TextStyle? textStyle;

  /// 光标样式
  final Widget? cursor;

  /// 是否显示光标
  final bool showCursor;

  /// 是否只允许数字输入
  final bool onlyNumber;

  /// 边框圆角
  final double borderRadius;

  /// 背景颜色
  final Color? backgroundColor;

  /// 是否为密码模式（显示为黑点）
  final bool obscureText;

  /// 密码模式下的黑点大小
  final double? obscureSize;

  /// 密码模式下的黑点颜色
  final Color? obscureColor;

  const CustomVerificationCode({
    super.key,
    this.length = 4,
    required this.onCompleted,
    this.onChanged,
    this.validator,
    this.autoFocus = false,
    this.width = 56,
    this.height = 56,
    this.spacing = 8,
    this.borderColor,
    this.focusedBorderColor,
    this.filledBorderColor,
    this.errorBorderColor,
    this.textStyle,
    this.cursor,
    this.showCursor = true,
    this.onlyNumber = true,
    this.borderRadius = 8,
    this.backgroundColor,
    this.isAutoWidth = false,
    this.obscureText = false,
    this.obscureSize = 12,
    this.obscureColor,
  });

  @override
  State<CustomVerificationCode> createState() => _CustomVerificationCodeState();
}

class _CustomVerificationCodeState extends State<CustomVerificationCode> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_focusNode);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 默认颜色
    final defaultBorderColor = widget.borderColor ?? Colors.grey.shade300;
    final defaultFocusedBorderColor =
        widget.focusedBorderColor ?? Theme.of(context).primaryColor;
    final defaultFilledBorderColor =
        widget.filledBorderColor ?? defaultFocusedBorderColor;
    final defaultErrorBorderColor = widget.errorBorderColor ?? Colors.redAccent;

    // 默认文本样式
    final defaultTextStyle = widget.textStyle ??
        TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : const Color.fromRGBO(30, 60, 87, 1),
        );

    if (widget.isAutoWidth) {
      return LayoutBuilder(
        builder: (context, constraints) {
          // 计算每个输入框的宽度
          // 总宽度减去间距的总宽度，再除以输入框数量
          final totalSpacing = widget.spacing! * (widget.length - 1);
          final itemWidth =
              (constraints.maxWidth - totalSpacing) / widget.length;

          // 创建自适应宽度的主题
          final adaptivePinTheme = PinTheme(
            width: itemWidth,
            height: widget.height!,
            textStyle: defaultTextStyle,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(color: defaultBorderColor),
              color: widget.backgroundColor,
            ),
          );

          // 默认光标
          final defaultCursor = widget.cursor ??
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: defaultFocusedBorderColor,
                  ),
                ],
              );

          return Pinput(
            controller: _controller,
            focusNode: _focusNode,
            length: widget.length,
            defaultPinTheme: adaptivePinTheme,
            separatorBuilder: (index) => SizedBox(width: widget.spacing),
            onChanged: widget.onChanged,
            onCompleted: widget.onCompleted,
            validator: widget.validator ??
                (value) {
                  return value?.length == widget.length ? null : '请输入完整的验证码';
                },
            keyboardType:
                widget.onlyNumber ? TextInputType.number : TextInputType.text,
            cursor: widget.showCursor ? defaultCursor : null,
            obscureText: widget.obscureText,
            obscuringCharacter: '●',
            obscuringWidget: widget.obscureText
                ? _buildObscureWidget(
                    widget.obscureColor ?? Theme.of(context).primaryColor,
                    widget.obscureSize!,
                  )
                : null,
            focusedPinTheme: adaptivePinTheme.copyWith(
              decoration: adaptivePinTheme.decoration!.copyWith(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(color: defaultFocusedBorderColor),
              ),
            ),
            submittedPinTheme: adaptivePinTheme.copyWith(
              decoration: adaptivePinTheme.decoration!.copyWith(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                border: Border.all(color: defaultFilledBorderColor),
              ),
            ),
            errorPinTheme: adaptivePinTheme.copyBorderWith(
              border: Border.all(color: defaultErrorBorderColor),
            ),
          );
        },
      );
    } else {
      // 默认PIN主题
      final defaultPinTheme = PinTheme(
        width: widget.width!,
        height: widget.height!,
        textStyle: defaultTextStyle,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(color: defaultBorderColor),
          color: widget.backgroundColor,
        ),
      );

      // 默认光标
      final defaultCursor = widget.cursor ??
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 9),
                width: 22,
                height: 1,
                color: defaultFocusedBorderColor,
              ),
            ],
          );

      return Pinput(
        controller: _controller,
        focusNode: _focusNode,
        length: widget.length,
        defaultPinTheme: defaultPinTheme,
        separatorBuilder: (index) => SizedBox(width: widget.spacing),
        onChanged: widget.onChanged,
        onCompleted: widget.onCompleted,
        validator: widget.validator ??
            (value) {
              return value?.length == widget.length ? null : '请输入完整的验证码';
            },
        keyboardType:
            widget.onlyNumber ? TextInputType.number : TextInputType.text,
        cursor: widget.showCursor ? defaultCursor : null,
        obscureText: widget.obscureText,
        obscuringCharacter: '●',
        obscuringWidget: widget.obscureText
            ? _buildObscureWidget(
                widget.obscureColor ?? Theme.of(context).primaryColor,
                widget.obscureSize!,
              )
            : null,
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(color: defaultFocusedBorderColor),
          ),
        ),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(color: defaultFilledBorderColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyBorderWith(
          border: Border.all(color: defaultErrorBorderColor),
        ),
      );
    }
  }

  /// 构建密码模式下的黑点
  Widget _buildObscureWidget(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
