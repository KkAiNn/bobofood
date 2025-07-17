class CheckUtils {
  /// 是否为空（null 或 trim 后为空）
  static bool isNullOrEmpty(String? text) {
    return text == null || text.trim().isEmpty;
  }

  /// 是否为邮箱地址
  static bool isEmail(String text) {
    return RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(text);
  }

  /// 是否为中国大陆手机号
  static bool isPhoneNumber(String text) {
    return RegExp(r'^1[3-9]\d{9}$').hasMatch(text);
  }

  /// 是否为纯数字
  static bool isNumeric(String text) {
    return RegExp(r'^\d+$').hasMatch(text);
  }

  /// 是否为字母+数字
  static bool isAlphanumeric(String text) {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(text);
  }

  /// 是否为中文
  static bool isChinese(String text) {
    return RegExp(r'^[\u4e00-\u9fa5]+$').hasMatch(text);
  }

  /// 是否包含 emoji
  static bool containsEmoji(String text) {
    return RegExp(r'[\u{1F600}-\u{1F64F}]', unicode: true).hasMatch(text);
  }

  /// 是否包含敏感词（传入自定义敏感词列表）
  static bool containsSensitiveWord(String text, List<String> sensitiveWords) {
    return sensitiveWords.any((word) => text.contains(word));
  }

  /// 检查是否为合法密码（8-20位，必须包含字母和数字）
  static bool isValidPassword(String text) {
    return RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,20}$').hasMatch(text);
  }

  /// 限制最大长度（中文算2个字符）
  static bool isWithinMaxLength(String text, int maxLength) {
    int length = 0;
    for (var codeUnit in text.runes) {
      length += (codeUnit > 0xFF) ? 2 : 1;
    }
    return length <= maxLength;
  }

  static String? checkString(String? string) {
    return string ?? '';
  }
}
