// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bobofood/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:bobofood/common/extension/fix_auto_lines.dart';

/// 通用文本组件，支持样式配置、默认字体、颜色等
class AppText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;

  final bool isUnderline;
  final Color? underlineColor;
  const AppText(
    this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.fontSize = 14,
    this.color,
    this.fontWeight = FontWeight.normal,
    this.decoration,
    this.isUnderline = false,
    this.underlineColor,
  });

  Widget buildText() {
    return Text(
      data.fixAutoLines(),
      style: style != null
          ? style!.copyWith(
              decoration: isUnderline
                  ? TextDecoration.underline
                  : decoration ?? TextDecoration.none,
              decorationColor:
                  underlineColor ?? AppColors.colors.bordersAndSeparators.link,
              decorationStyle: TextDecorationStyle.solid,
              decorationThickness: 2.h,
            )
          : TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              decoration: decoration ?? TextDecoration.none,
              decorationColor: AppColors.colors.bordersAndSeparators.link,
              decorationStyle: TextDecorationStyle.solid,
            ),
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      // ignore: deprecated_member_use
      textScaleFactor: textScaleFactor,
      textScaler: textScaler ?? TextScaler.noScaling,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }

  Widget buildUnderlineText() {
    return buildText();
    // return Container(
    //   padding: EdgeInsets.only(bottom: 2.h),
    //   decoration: BoxDecoration(
    //     border: Border(
    //       bottom: BorderSide(
    //         color: underlineColor ?? AppColors.colors.bordersAndSeparators.link,
    //         width: 2.h,
    //       ),
    //     ),
    //   ),
    //   child: buildText(),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return isUnderline ? buildUnderlineText() : buildText();
  }

  /// 自动截断文本并在中间显示省略号（精确多行处理）
  static Widget ellipsisText({
    required String text,
    TextStyle? style,
    int maxLines = 1,
    double? fontSize,
    Color? color,
    TextAlign textAlign = TextAlign.left,
  }) {
    return _PreciseMiddleEllipsisText(
      text: text,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      fontSize: fontSize,
      color: color,
    );
  }
}

/// 内部组件：中间省略文本，支持精确多行截断
class _PreciseMiddleEllipsisText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int maxLines;
  final TextAlign textAlign;
  final double? fontSize;
  final Color? color;

  const _PreciseMiddleEllipsisText({
    required this.text,
    this.style,
    this.maxLines = 2,
    this.textAlign = TextAlign.start,
    this.fontSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final defaultStyle = Theme.of(context).textTheme.bodyMedium!;
        final effectiveStyle = (style ?? defaultStyle).copyWith(
          fontSize: fontSize,
          color: color,
        );

        final maxHeight = _textHeight(effectiveStyle) * maxLines;
        final textSize = _measureText(
          text,
          effectiveStyle,
          constraints.maxWidth,
        );

        if (textSize.height <= maxHeight) {
          return Text(
            text,
            style: effectiveStyle,
            textAlign: textAlign,
            maxLines: maxLines,
          );
        }

        final truncated = _findOptimalTruncation(
          text,
          effectiveStyle,
          constraints.maxWidth,
          maxHeight,
        );

        return AppText(
          truncated,
          style: effectiveStyle,
          textAlign: textAlign,
          maxLines: maxLines,
        );
      },
    );
  }

  double _textHeight(TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: 'A', style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    return painter.height;
  }

  Size _measureText(String text, TextStyle style, double maxWidth) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);
    return painter.size;
  }

  String _findOptimalTruncation(
    String text,
    TextStyle style,
    double maxWidth,
    double maxHeight,
  ) {
    int left = 10;
    int right = text.length;
    String best = _MiddleEllipsisUtil.truncateMiddle(text, 10);

    while (left <= right) {
      final mid = (left + right) ~/ 2;
      final candidate = _MiddleEllipsisUtil.truncateMiddle(text, mid);
      final size = _measureText(candidate, style, maxWidth);

      if (size.height <= maxHeight) {
        best = candidate;
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }

    return best;
  }
}

/// 工具类：中间省略号字符串处理
class _MiddleEllipsisUtil {
  static String truncateMiddle(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    if (maxLength <= 3) return '...';

    final leftLen = (maxLength - 3) ~/ 2;
    final rightLen = maxLength - 3 - leftLen;

    return '${text.substring(0, leftLen)}...${text.substring(text.length - rightLen)}';
  }
}
