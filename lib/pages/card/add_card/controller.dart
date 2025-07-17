import 'package:bobofood/common/model/card.dart';
import 'package:bobofood/common/widget/app_form_manager.dart';
import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:bobofood/utils/date.dart';
import 'package:bobofood/utils/datetime_picker.dart';
import 'package:bobofood/utils/id_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCardController extends GetxController {
  AddCardController();

  CardModel? card;

  final AppFormManager formManager = AppFormManager();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late AppInputController nameController;
  late AppInputController numberController;
  late AppInputController dateController;
  late AppInputController cvvController;

  _initData() {
    update(["add_card"]);
  }

  void onTap() {}

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments as CardModel?;
    if (arg != null) {
      card = arg;
    } else {
      card = CardModel(
        name: '',
        number: '',
        date: '',
        cvv: '',
        bank: '',
        isDefault: false,
      );
    }
    nameController = formManager.register('name', initialValue: card?.name);
    numberController =
        formManager.register('number', initialValue: card?.number);
    dateController = formManager.register('date', initialValue: card?.date);
    cvvController = formManager.register('bank', initialValue: card?.cvv);
  }

  void onSetDefault(bool value) {
    card?.isDefault = value;
    _initData();
  }

  void onDatePicker() async {
    var res = await showAppDateTimePicker(
      mode: AppDateTimePickerMode.date,
      initialTime: DateTime.now(),
    );
    if (res != null) {
      dateController.text = JiffyDateUtils.formatDate(res);
    }
  }

  void onSave() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    card = card?.copyWith(
      id: card?.id ?? IdUtils.uuid(),
      name: nameController.text,
      number: numberController.text,
      date: dateController.text,
      cvv: cvvController.text,
      bank: 'Mastercard',
    );
    Get.back(result: card);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
