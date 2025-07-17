import 'package:bobofood/pages/setting/controller.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  LanguageController();

  SettingController settingController = Get.find<SettingController>();

  String selectedLanguage = 'English';

  List<String> languages = [
    'English',
    'Hindi',
    'Sanskrit',
    'French',
    'Spanish',
    'Chinese',
    'Japanese',
    'Korean'
  ];

  _initData() {
    update(["language"]);
  }

  void onTap() {}

  @override
  void onInit() {
    super.onInit();
    selectedLanguage = settingController.selectedLanguage;
  }

  void onLanguageChange(String value) {
    selectedLanguage = value;
    _initData();
  }

  void onSave() {
    Get.back(result: selectedLanguage);
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
