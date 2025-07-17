import 'package:jiffy/jiffy.dart';

/// 基于Jiffy的日期工具类
/// 提供日期格式化、比较、计算、判断等常用功能
class JiffyDateUtils {
  // 常用日期格式常量
  static const String FORMAT_YYYY_MM_DD = 'yyyy-MM-dd';
  static const String FORMAT_YYYY_MM_DD_HH_MM = 'yyyy-MM-dd HH:mm';
  static const String FORMAT_YYYY_MM_DD_HH_MM_SS = 'yyyy-MM-dd HH:mm:ss';
  static const String FORMAT_MM_DD = 'MM-dd';
  static const String FORMAT_HH_MM = 'HH:mm';
  static const String FORMAT_HH_MM_SS = 'HH:mm:ss';
  static const String FORMAT_YYYY_MM_DD_CN = 'yyyy年MM月dd日';
  static const String FORMAT_MM_DD_CN = 'MM月dd日';
  static const String FORMAT_YYYY_MM_DD_HH_MM_CN = 'yyyy年MM月dd日 HH:mm';

  /// 获取当前时间
  static Jiffy now() => Jiffy.now();

  /// 创建Jiffy对象
  static Jiffy create(dynamic dateTime) {
    if (dateTime is DateTime) {
      return Jiffy.parseFromDateTime(dateTime);
    } else if (dateTime is String) {
      return Jiffy.parse(dateTime);
    } else if (dateTime is int) {
      return Jiffy.parseFromMillisecondsSinceEpoch(dateTime);
    } else {
      throw ArgumentError('不支持的日期类型: ${dateTime.runtimeType}');
    }
  }

  // ========== 格式化相关 ==========

  /// 格式化日期为字符串
  /// [dateTime] 日期对象（支持DateTime、String、int、Jiffy）
  /// [format] 格式化模式，默认为 yyyy-MM-dd HH:mm:ss
  static String format(
    dynamic dateTime, [
    String format = FORMAT_YYYY_MM_DD_HH_MM_SS,
  ]) {
    return create(dateTime).format(pattern: format);
  }

  /// 格式化为 yyyy-MM-dd
  static String formatDate(dynamic dateTime) {
    return format(dateTime, FORMAT_YYYY_MM_DD);
  }

  /// 格式化为 HH:mm:ss
  static String formatTime(dynamic dateTime) {
    return format(dateTime, FORMAT_HH_MM_SS);
  }

  /// 格式化为 yyyy-MM-dd HH:mm
  static String formatDateTime(dynamic dateTime) {
    return format(dateTime, FORMAT_YYYY_MM_DD_HH_MM);
  }

  /// 格式化为中文日期格式
  static String formatChinese(dynamic dateTime) {
    return format(dateTime, FORMAT_YYYY_MM_DD_CN);
  }

  // ========== 比较相关 ==========

  /// 比较两个日期
  /// 返回值：-1（date1 < date2），0（相等），1（date1 > date2）
  static int compare(dynamic date1, dynamic date2) {
    final jiffy1 = create(date1);
    final jiffy2 = create(date2);

    if (jiffy1.isBefore(jiffy2)) return -1;
    if (jiffy1.isAfter(jiffy2)) return 1;
    return 0;
  }

  /// 判断date1是否在date2之前
  static bool isBefore(dynamic date1, dynamic date2) {
    return create(date1).isBefore(create(date2));
  }

  /// 判断date1是否在date2之后
  static bool isAfter(dynamic date1, dynamic date2) {
    return create(date1).isAfter(create(date2));
  }

  /// 判断两个日期是否相等
  static bool isEqual(dynamic date1, dynamic date2) {
    return create(date1).isSame(create(date2));
  }

  /// 判断两个日期是否是同一天
  static bool isSameDay(dynamic date1, dynamic date2) {
    return create(date1).isSame(create(date2), unit: Unit.day);
  }

  /// 判断两个日期是否是同一个月
  static bool isSameMonth(dynamic date1, dynamic date2) {
    return create(date1).isSame(create(date2), unit: Unit.month);
  }

  /// 判断两个日期是否是同一年
  static bool isSameYear(dynamic date1, dynamic date2) {
    return create(date1).isSame(create(date2), unit: Unit.year);
  }

  // ========== 日期差计算 ==========

  /// 计算两个日期的差值（天数）
  static int daysBetween(dynamic date1, dynamic date2) {
    return create(date2).diff(create(date1), unit: Unit.day).abs().toInt();
  }

  /// 计算两个日期的差值（小时）
  static int hoursBetween(dynamic date1, dynamic date2) {
    return create(date2).diff(create(date1), unit: Unit.hour).abs().toInt();
  }

  /// 计算两个日期的差值（分钟）
  static int minutesBetween(dynamic date1, dynamic date2) {
    return create(date2).diff(create(date1), unit: Unit.minute).abs().toInt();
  }

  /// 计算两个日期的差值（秒）
  static int secondsBetween(dynamic date1, dynamic date2) {
    return create(date2).diff(create(date1), unit: Unit.second).abs().toInt();
  }

  /// 计算两个日期的差值（毫秒）
  static int millisecondsBetween(dynamic date1, dynamic date2) {
    return create(
      date2,
    ).diff(create(date1), unit: Unit.millisecond).abs().toInt();
  }

  /// 计算年龄
  static int calculateAge(dynamic birthDate) {
    return now().diff(create(birthDate), unit: Unit.year).toInt();
  }

  /// 获取详细的时间差信息
  static Map<String, int> getDetailedDifference(dynamic date1, dynamic date2) {
    final jiffy1 = create(date1);
    final jiffy2 = create(date2);

    return {
      'years': jiffy2.diff(jiffy1, unit: Unit.year).abs().toInt(),
      'months': jiffy2.diff(jiffy1, unit: Unit.month).abs().toInt(),
      'days': jiffy2.diff(jiffy1, unit: Unit.day).abs().toInt(),
      'hours': jiffy2.diff(jiffy1, unit: Unit.hour).abs().toInt(),
      'minutes': jiffy2.diff(jiffy1, unit: Unit.minute).abs().toInt(),
      'seconds': jiffy2.diff(jiffy1, unit: Unit.second).abs().toInt(),
      'milliseconds': jiffy2.diff(jiffy1, unit: Unit.millisecond).abs().toInt(),
    };
  }

  // ========== 时间增加/减少 ==========

  /// 增加指定的时间
  static Jiffy add(
    dynamic dateTime, {
    int years = 0,
    int months = 0,
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliseconds = 0,
  }) {
    Jiffy jiffy = create(dateTime);

    if (years != 0) jiffy = jiffy.add(years: years);
    if (months != 0) jiffy = jiffy.add(months: months);
    if (days != 0) jiffy = jiffy.add(days: days);
    if (hours != 0) jiffy = jiffy.add(hours: hours);
    if (minutes != 0) jiffy = jiffy.add(minutes: minutes);
    if (seconds != 0) jiffy = jiffy.add(seconds: seconds);
    if (milliseconds != 0) jiffy = jiffy.add(milliseconds: milliseconds);

    return jiffy;
  }

  /// 减少指定的时间
  static Jiffy subtract(
    dynamic dateTime, {
    int years = 0,
    int months = 0,
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliseconds = 0,
  }) {
    Jiffy jiffy = create(dateTime);

    if (years != 0) jiffy = jiffy.subtract(years: years);
    if (months != 0) jiffy = jiffy.subtract(months: months);
    if (days != 0) jiffy = jiffy.subtract(days: days);
    if (hours != 0) jiffy = jiffy.subtract(hours: hours);
    if (minutes != 0) jiffy = jiffy.subtract(minutes: minutes);
    if (seconds != 0) jiffy = jiffy.subtract(seconds: seconds);
    if (milliseconds != 0) jiffy = jiffy.subtract(milliseconds: milliseconds);

    return jiffy;
  }

  /// 增加天数
  static Jiffy addDays(dynamic dateTime, int days) {
    return create(dateTime).add(days: days);
  }

  /// 减少天数
  static Jiffy subtractDays(dynamic dateTime, int days) {
    return create(dateTime).subtract(days: days);
  }

  /// 增加小时
  static Jiffy addHours(dynamic dateTime, int hours) {
    return create(dateTime).add(hours: hours);
  }

  /// 减少小时
  static Jiffy subtractHours(dynamic dateTime, int hours) {
    return create(dateTime).subtract(hours: hours);
  }

  /// 增加分钟
  static Jiffy addMinutes(dynamic dateTime, int minutes) {
    return create(dateTime).add(minutes: minutes);
  }

  /// 减少分钟
  static Jiffy subtractMinutes(dynamic dateTime, int minutes) {
    return create(dateTime).subtract(minutes: minutes);
  }

  // ========== 时间段判断 ==========

  /// 判断日期是否在指定时间段内
  /// [date] 要判断的日期
  /// [startDate] 开始日期
  /// [endDate] 结束日期
  /// [inclusive] 是否包含边界，默认为true
  static bool isBetween(
    dynamic date,
    dynamic startDate,
    dynamic endDate, {
    bool inclusive = true,
  }) {
    final jiffy = create(date);
    final start = create(startDate);
    final end = create(endDate);

    if (inclusive) {
      return (jiffy.isSameOrAfter(start) && jiffy.isSameOrBefore(end));
    } else {
      return (jiffy.isAfter(start) && jiffy.isBefore(end));
    }
  }

  /// 判断日期是否在今天
  static bool isToday(dynamic date) {
    return isSameDay(date, now());
  }

  /// 判断日期是否在昨天
  static bool isYesterday(dynamic date) {
    return isSameDay(date, now().subtract(days: 1));
  }

  /// 判断日期是否在明天
  static bool isTomorrow(dynamic date) {
    return isSameDay(date, now().add(days: 1));
  }

  /// 判断日期是否在本周
  static bool isThisWeek(dynamic date) {
    final jiffy = create(date);
    final nowJiffy = now();
    final startOfWeek = nowJiffy.startOf(Unit.week);
    final endOfWeek = nowJiffy.endOf(Unit.week);

    return isBetween(jiffy, startOfWeek, endOfWeek);
  }

  /// 判断日期是否在本月
  static bool isThisMonth(dynamic date) {
    return isSameMonth(date, now());
  }

  /// 判断日期是否在本年
  static bool isThisYear(dynamic date) {
    return isSameYear(date, now());
  }

  // ========== 获取特定时间 ==========

  /// 获取一天的开始时间（00:00:00）
  static Jiffy startOfDay(dynamic date) {
    return create(date).startOf(Unit.day);
  }

  /// 获取一天的结束时间（23:59:59）
  static Jiffy endOfDay(dynamic date) {
    return create(date).endOf(Unit.day);
  }

  /// 获取一周的开始时间
  static Jiffy startOfWeek(dynamic date) {
    return create(date).startOf(Unit.week);
  }

  /// 获取一周的结束时间
  static Jiffy endOfWeek(dynamic date) {
    return create(date).endOf(Unit.week);
  }

  /// 获取一个月的开始时间
  static Jiffy startOfMonth(dynamic date) {
    return create(date).startOf(Unit.month);
  }

  /// 获取一个月的结束时间
  static Jiffy endOfMonth(dynamic date) {
    return create(date).endOf(Unit.month);
  }

  /// 获取一年的开始时间
  static Jiffy startOfYear(dynamic date) {
    return create(date).startOf(Unit.year);
  }

  /// 获取一年的结束时间
  static Jiffy endOfYear(dynamic date) {
    return create(date).endOf(Unit.year);
  }

  // ========== 实用方法 ==========

  /// 获取两个日期之间的所有日期
  static List<Jiffy> getDaysBetween(dynamic startDate, dynamic endDate) {
    final start = create(startDate);
    final end = create(endDate);
    final days = <Jiffy>[];

    Jiffy current = start;
    while (current.isSameOrBefore(end)) {
      days.add(current);
      current = current.add(days: 1);
    }

    return days;
  }

  /// 获取本月的所有日期
  static List<Jiffy> getAllDaysInMonth(dynamic date) {
    final jiffy = create(date);
    final start = jiffy.startOf(Unit.month);
    final end = jiffy.endOf(Unit.month);

    return getDaysBetween(start, end);
  }

  /// 获取友好的时间描述（如：刚刚、5分钟前、1小时前等）
  static String getTimeAgo(dynamic date) {
    final jiffy = create(date);
    final now = Jiffy.now();

    final diff = now.diff(jiffy, unit: Unit.second);

    if (diff < 60) {
      return '刚刚';
    } else if (diff < 3600) {
      return '${(diff / 60).floor()}分钟前';
    } else if (diff < 86400) {
      return '${(diff / 3600).floor()}小时前';
    } else if (diff < 2592000) {
      return '${(diff / 86400).floor()}天前';
    } else if (diff < 31536000) {
      return '${(diff / 2592000).floor()}个月前';
    } else {
      return '${(diff / 31536000).floor()}年前';
    }
  }

  /// 判断是否为闰年
  static bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  /// 获取指定年月的天数
  static int getDaysInMonth(int year, int month) {
    switch (month) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        return 31;
      case 4:
      case 6:
      case 9:
      case 11:
        return 30;
      case 2:
        return isLeapYear(year) ? 29 : 28;
      default:
        throw ArgumentError('Invalid month: $month');
    }
  }

  /// 获取指定日期所在月份的天数
  static int getDaysCountInMonth(dynamic date) {
    final jiffy = create(date);
    return getDaysInMonth(jiffy.year, jiffy.month);
  }

  /// 获取星期几的中文名称
  static String getWeekdayName(dynamic date) {
    final weekday = create(date).dateTime.weekday;
    const weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return weekdays[weekday - 1];
  }

  /// 获取月份的中文名称
  static String getMonthName(dynamic date) {
    final month = create(date).dateTime.month;
    const months = [
      '一月',
      '二月',
      '三月',
      '四月',
      '五月',
      '六月',
      '七月',
      '八月',
      '九月',
      '十月',
      '十一月',
      '十二月',
    ];
    return months[month - 1];
  }
}
