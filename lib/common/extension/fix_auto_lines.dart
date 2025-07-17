import 'package:characters/characters.dart';

/// 文本换行优化扩展
extension FixAutoLines on String {
  /// 零宽空格字符
  static const String _zeroWidthSpace = '\u200B';

  /// 返回插入零宽空格的字符串，用于显示优化换行
  ///
  /// 策略：
  /// 1. 在中英文之间插入零宽空格
  /// 2. 在数字和字母之间插入零宽空格
  /// 3. 在标点符号前后插入零宽空格
  /// 4. 长单词中间插入零宽空格
  String fixAutoLines({
    bool optimizeForMixedText = true,
    bool breakLongWords = true,
    int longWordThreshold = 20,
  }) {
    if (isEmpty) return this;

    if (!optimizeForMixedText) {
      // 简单模式：每个字符后都插入零宽空格
      return Characters(this).join(_zeroWidthSpace);
    }

    // 优化模式：智能插入零宽空格
    return _smartInsertZeroWidthSpace(
      breakLongWords: breakLongWords,
      longWordThreshold: longWordThreshold,
    );
  }

  /// 智能插入零宽空格
  String _smartInsertZeroWidthSpace({
    required bool breakLongWords,
    required int longWordThreshold,
  }) {
    final buffer = StringBuffer();
    final characters = Characters(this);
    String? prev;

    for (final char in characters) {
      if (prev != null) {
        // 在需要的地方插入零宽空格
        if (_shouldInsertBreak(prev, char)) {
          buffer.write(_zeroWidthSpace);
        }
      }

      buffer.write(char);
      prev = char;
    }

    String result = buffer.toString();

    // 处理长单词
    if (breakLongWords) {
      result = _breakLongWords(result, longWordThreshold);
    }

    return result;
  }

  /// 判断是否应该在两个字符之间插入零宽空格
  bool _shouldInsertBreak(String prev, String curr) {
    // 中文字符的Unicode范围
    bool isChinese(String char) {
      final code = char.codeUnitAt(0);
      return (code >= 0x4e00 && code <= 0x9fff) || // 基本汉字
          (code >= 0x3400 && code <= 0x4dbf) || // 扩展A
          (code >= 0x20000 && code <= 0x2a6df); // 扩展B
    }

    // 英文字母
    bool isEnglish(String char) {
      return RegExp(r'[a-zA-Z]').hasMatch(char);
    }

    // 数字
    bool isDigit(String char) {
      return RegExp(r'[0-9]').hasMatch(char);
    }

    // 标点符号
    bool isPunctuation(String char) {
      return RegExp(r'[.,!?;:，。！？；：]').hasMatch(char);
    }

    // 中英文之间
    if ((isChinese(prev) && isEnglish(curr)) ||
        (isEnglish(prev) && isChinese(curr))) {
      return true;
    }

    // 中文和数字之间
    if ((isChinese(prev) && isDigit(curr)) ||
        (isDigit(prev) && isChinese(curr))) {
      return true;
    }

    // 数字和字母之间（某些情况）
    if ((isDigit(prev) && isEnglish(curr)) ||
        (isEnglish(prev) && isDigit(curr))) {
      return true;
    }

    // 标点符号前后
    if (isPunctuation(prev) || isPunctuation(curr)) {
      return true;
    }

    return false;
  }

  /// 处理长单词
  String _breakLongWords(String text, int threshold) {
    return text.replaceAllMapped(RegExp(r'[a-zA-Z0-9]{$threshold,}'), (match) {
      final word = match.group(0)!;
      final buffer = StringBuffer();

      for (int i = 0; i < word.length; i++) {
        if (i > 0 && i % (threshold ~/ 2) == 0) {
          buffer.write(_zeroWidthSpace);
        }
        buffer.write(word[i]);
      }

      return buffer.toString();
    });
  }

  /// 获取原始文本的选中内容
  ///
  /// 更准确的选择位置计算
  String getSelectedOriginalText({required int start, required int end}) {
    if (isEmpty) return '';

    // 构建位置映射
    final positionMap = <int, int>{}; // fixedIndex -> originalIndex
    int originalIndex = 0;
    int fixedIndex = 0;

    final fixedText = fixAutoLines();

    for (int i = 0; i < fixedText.length; i++) {
      if (fixedText[i] == _zeroWidthSpace) {
        // 跳过零宽空格，不增加原始索引
        fixedIndex++;
      } else {
        positionMap[fixedIndex] = originalIndex;
        originalIndex++;
        fixedIndex++;
      }
    }

    // 添加末尾位置的映射
    positionMap[fixedIndex] = originalIndex;

    // 转换选择位置
    final originalStart = positionMap[start] ?? 0;
    final originalEnd = positionMap[end] ?? length;

    return substring(
      originalStart.clamp(0, length),
      originalEnd.clamp(0, length),
    );
  }

  /// 获取原始文本中的位置对应的修复文本位置
  int getFixedPosition(int originalPosition) {
    if (isEmpty || originalPosition <= 0) return 0;

    final fixedText = fixAutoLines();
    int originalIndex = 0;

    for (int i = 0; i < fixedText.length; i++) {
      if (fixedText[i] == _zeroWidthSpace) {
        continue; // 跳过零宽空格
      }

      if (originalIndex == originalPosition) {
        return i;
      }
      originalIndex++;
    }

    return fixedText.length;
  }

  /// 移除零宽空格，恢复原始文本
  String removeZeroWidthSpaces() {
    return replaceAll(_zeroWidthSpace, '');
  }

  /// 获取修复后的文本长度（不包括零宽空格）
  int get originalLength {
    return removeZeroWidthSpaces().length;
  }
}
