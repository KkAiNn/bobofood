import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:get/get.dart';

enum AppDateTimePickerMode {
  date,
  time,
  dateTime,
}

Future<DateTime?> showAppDateTimePicker({
  AppDateTimePickerMode mode = AppDateTimePickerMode.date,
  DateTime? initialTime,
  DateTime? minTime,
  DateTime? maxTime,
  picker.LocaleType locale = picker.LocaleType.zh,
  picker.DatePickerTheme? theme,
}) async {
  final completer = Completer<DateTime?>();

  final now = DateTime.now();
  final current = initialTime ?? now;
  final min = minTime ?? DateTime(1900);
  final max = maxTime ?? DateTime.now();

  final pickerTheme = theme ??
      picker.DatePickerTheme(
        backgroundColor: Colors.white,
        itemStyle: const TextStyle(fontSize: 18, color: Colors.black),
        doneStyle: const TextStyle(fontSize: 16, color: Colors.blue),
        cancelStyle: const TextStyle(fontSize: 16, color: Colors.grey),
      );

  void onConfirm(DateTime date) => completer.complete(date);

  switch (mode) {
    case AppDateTimePickerMode.date:
      picker.DatePicker.showDatePicker(
        Get.context!,
        theme: pickerTheme,
        minTime: min,
        maxTime: max,
        currentTime: current,
        locale: locale,
        onConfirm: onConfirm,
      );
      break;

    case AppDateTimePickerMode.time:
      picker.DatePicker.showTimePicker(
        Get.context!,
        theme: pickerTheme,
        currentTime: current,
        locale: locale,
        onConfirm: onConfirm,
      );
      break;

    case AppDateTimePickerMode.dateTime:
      picker.DatePicker.showDateTimePicker(
        Get.context!,
        theme: pickerTheme,
        minTime: min,
        maxTime: max,
        currentTime: current,
        locale: locale,
        onConfirm: onConfirm,
      );
      break;
  }

  return completer.future;
}
