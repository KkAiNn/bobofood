import 'package:bobofood/common/model/address.dart';
import 'package:bobofood/pages/address/controller.dart';
import 'package:get/get.dart';

class ChangeAddressController extends GetxController {
  ChangeAddressController();

  AddressController addressController = Get.find<AddressController>();

  AddressModel? selectedAddress;

  _initData() {
    update(["change_address"]);
  }

  void onTap() {}

  void onTapAddress(AddressModel address) {
    selectedAddress = address;
    update(["change_address"]);
  }

  void onSave() {
    Get.back(result: selectedAddress);
  }

  @override
  void onInit() {
    super.onInit();
    var address = Get.arguments as AddressModel?;
    if (address != null) {
      selectedAddress = address;
    }
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
