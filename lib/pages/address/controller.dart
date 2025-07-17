import 'package:bobofood/common/model/address.dart';
import 'package:bobofood/router/app_router.dart';
import 'package:bobofood/services/mock_data.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  final List<AddressModel> addressList = MockData.address;

  AddressModel? get defaultAddress =>
      addressList.firstWhereOrNull((element) => element.isDefault);

  List<AddressModel> get otherAddress =>
      addressList.where((element) => !element.isDefault).toList();

  _initData() {
    update(["address"]);
  }

  void addAddress(AddressModel address) {
    addressList.add(address);
  }

  void updateAddress(AddressModel address) {
    final index = addressList.indexWhere((element) => element.id == address.id);
    if (index != -1) {
      addressList[index] = address;
      if (address.isDefault == true) {
        setDefaultAddress(address);
      }
    } else {
      addAddress(address);
    }
  }

  void deleteAddress(AddressModel address) {
    addressList.remove(address);
  }

  void setDefaultAddress(AddressModel address) {
    for (var element in addressList) {
      element.isDefault = false;
    }
    address.isDefault = true;
  }

  void onAddAddress() async {
    final res = await Get.toNamed(AppRoute.addAddress);
    if (res != null) {
      updateAddress(res as AddressModel);
    }
    _initData();
  }

  void onEditDefaultAddress() async {
    final res =
        await Get.toNamed(AppRoute.addAddress, arguments: defaultAddress);
    if (res != null) {
      updateAddress(res as AddressModel);
    }
    _initData();
  }

  void onEditAddress(AddressModel address) async {
    final res = await Get.toNamed(AppRoute.addAddress, arguments: address);
    if (res != null) {
      updateAddress(res as AddressModel);
    }
    _initData();
  }
}
