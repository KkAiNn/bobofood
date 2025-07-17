import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:flutter/material.dart';

/// 表单控制器管理类，用于统一管理多个AppInputController
class AppFormManager {
  final Map<String, AppInputController> _controllers = {};
  final VoidCallback? onAnyControllerChanged;

  AppFormManager({this.onAnyControllerChanged});

  /// 注册一个控制器
  AppInputController register(String name,
      {VoidCallback? onTextChanged, String? initialValue}) {
    if (_controllers.containsKey(name)) {
      return _controllers[name]!;
    }

    final controller = AppInputController(onTextChanged: () {
      onTextChanged?.call();
      onAnyControllerChanged?.call();
    });
    controller.text = initialValue ?? '';
    _controllers[name] = controller;
    return controller;
  }

  /// 获取一个已注册的控制器
  AppInputController? get(String name) {
    return _controllers[name];
  }

  String? getValue(String name) {
    final controller = _controllers[name];
    return controller?.text;
  }

  /// 获取所有控制器
  Map<String, AppInputController> getAll() {
    return Map.unmodifiable(_controllers);
  }

  /// 获取所有控制器的值
  Map<String, String> getAllValues() {
    final values = <String, String>{};
    _controllers.forEach((key, controller) {
      values[key] = controller.text;
    });
    return values;
  }

  /// 获取所有控制器的值
  Map<String, String> getAllEmptyValues() {
    final values = <String, String>{};
    _controllers.forEach((key, controller) {
      if (controller.text.isEmpty) {
        values[key] = controller.text;
      }
    });
    return values;
  }

  /// 设置控制器的值
  void setValue(String name, dynamic value) {
    final controller = _controllers[name];
    if (controller != null) {
      controller.text = value;
    }
  }

  /// 批量设置控制器的值
  void setValues(Map<String, dynamic> values) {
    values.forEach((key, value) {
      setValue(key, value);
    });
  }

  /// 清空所有控制器的值
  void clearAll() {
    _controllers.forEach((key, controller) {
      controller.clear();
    });
  }

  /// 检查所有控制器是否有值
  bool hasAllValues() {
    return _controllers.values
        .every((controller) => controller.text.isNotEmpty);
  }

  /// 检查指定控制器是否有值
  bool hasValue(String name) {
    final controller = _controllers[name];
    return controller != null && controller.text.isNotEmpty;
  }

  /// 释放所有控制器
  void dispose() {
    _controllers.forEach((key, controller) {
      controller.dispose();
    });
    _controllers.clear();
  }
}
