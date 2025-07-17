import 'dart:async';
import 'package:flutter/material.dart';

class CountdownController extends ChangeNotifier {
  final int initialSeconds;

  late int _secondsLeft;
  bool _isRunning = false;
  Timer? _timer;

  CountdownController({this.initialSeconds = 60}) {
    _secondsLeft = initialSeconds;
  }

  /// 当前剩余秒数
  int get secondsLeft => _secondsLeft;

  String get secondsLeftString => _secondsLeft.toString().padLeft(2, '0');

  /// 是否正在倒计时中
  bool get isRunning => _isRunning;

  /// 展示文案（如：获取验证码/59s）
  String get displayText => _isRunning ? '${_secondsLeft}s' : '获取验证码';

  /// 开始倒计时
  void start() {
    if (_isRunning) return;

    _isRunning = true;
    _secondsLeft = initialSeconds;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _secondsLeft--;

      if (_secondsLeft <= 0) {
        timer.cancel();
        _isRunning = false;
      }

      notifyListeners();
    });
  }

  /// 手动重置
  void reset() {
    _timer?.cancel();
    _secondsLeft = initialSeconds;
    _isRunning = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
