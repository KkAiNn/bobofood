import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bobofood/utils/toast.dart';

class AppPopScope extends StatefulWidget {
  final Widget child;
  final Duration duration;
  const AppPopScope({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<AppPopScope> createState() => _AppPopScopeState();
}

class _AppPopScopeState extends State<AppPopScope> {
  DateTime? _lastTime;

  Future<bool> _isExit() async {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime!) > widget.duration) {
      _lastTime = DateTime.now();
      AppToast.show('再次点击退出应用');
      return Future.value(false);
    }

    await SystemNavigator.pop();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        _isExit();
      },
      child: widget.child,
    );
  }
}
