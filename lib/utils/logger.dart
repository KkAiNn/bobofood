import 'dart:io' show File, FileMode;
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// 获取统一的 logger 实例
final AppLogger logger = AppLogger();

/// 日志封装类
class AppLogger extends Logger {
  AppLogger()
      : super(
          printer: PrettyPrinter(
            methodCount: 2,
            errorMethodCount: 8,
            lineLength: 120,
            colors: true,
            printEmojis: true,
            dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
          ),
          filter: _CustomFilter(),
          output: _getPlatformOutput(),
        );
}

/// 输出策略：根据平台和构建模式决定输出方式
LogOutput _getPlatformOutput() {
  if (kIsWeb) return ConsoleOutput(); // Web 只能控制台输出
  return kDebugMode ? ConsoleOutput() : FileOutput(); // App Release 模式输出到文件
}

/// 自定义过滤器，保留所有日志
class _CustomFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) => true;
}

/// 非 Web 平台下的日志文件输出
class FileOutput extends LogOutput {
  late final Future<File> _logFileFuture = _getLogFile();

  @override
  void output(OutputEvent event) async {
    try {
      final file = await _logFileFuture;
      final logLine = '${event.lines.join('\n')}\n';
      await file.writeAsString(logLine, mode: FileMode.writeOnlyAppend);
    } catch (e) {
      logger.e("日志写入失败: $e");
    }
  }

  Future<File> _getLogFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, ".pili_logs");
    final file = File(path);
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    return file;
  }
}

/// 获取日志文件路径（用于查看或上传）
Future<File> getLogFile() async {
  final dir = await getApplicationDocumentsDirectory();
  final path = p.join(dir.path, ".pili_logs");
  final file = File(path);
  if (!await file.exists()) {
    await file.create(recursive: true);
  }
  return file;
}

/// 清空日志文件
Future<bool> clearLogs() async {
  try {
    final file = await getLogFile();
    await file.writeAsString('');
    return true;
  } catch (e) {
    logger.e("清空日志失败: $e");
    return false;
  }
}
