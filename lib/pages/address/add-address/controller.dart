import 'package:bobofood/common/widget/form/app_input.dart';
import 'package:bobofood/common/model/address.dart';
import 'package:bobofood/common/widget/app_form_manager.dart';
import 'package:bobofood/utils/id_utils.dart';
import 'package:get/get.dart';

class AddAddressController extends GetxController {
  final AppFormManager formManager = AppFormManager();

  bool get isDisabled => !isFormComplete();

  AddressModel? address;

  // 使用formManager注册控制器
  late AppInputController addressLabelController;
  late AppInputController deliveryInstructionsController;
  late AppInputController nameController;
  late AppInputController phoneCodeController;
  late AppInputController phoneController;
  late AppInputController streetController;
  late AppInputController zipCodeController;
  late AppInputController cityController;
  late AppInputController stateController;
  late AppInputController countryController;

  _initData() {
    update(["add_address"]);
  }

  onSwitchChange(bool value) {
    print(formManager.getAllEmptyValues());
    address = address?.copyWith(isDefault: value);
    update(["add_address"]);
  }

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments as AddressModel?;
    if (arg != null) {
      address = arg;
    } else {
      address = AddressModel(
          id: '',
          addressLabel: '',
          deliveryInstructions: '',
          name: '',
          phoneCode: '+00',
          phone: '',
          street: '',
          zipCode: '',
          city: '',
          state: '',
          country: '',
          isDefault: false);
    }
    _initializeControllers();
  }

  // 获取所有表单数据
  Map<String, String> getFormData() {
    return formManager.getAllValues();
  }

  // 强制初始化所有控制器
  void _initializeControllers() {
    addressLabelController = formManager.register('addressLabel',
        onTextChanged: _initData, initialValue: address?.addressLabel);
    deliveryInstructionsController = formManager.register(
        'deliveryInstructions',
        onTextChanged: _initData,
        initialValue: address?.deliveryInstructions);
    nameController = formManager.register('name',
        onTextChanged: _initData, initialValue: address?.name);
    phoneCodeController = formManager.register('phoneCode',
        onTextChanged: _initData, initialValue: address?.phoneCode ?? '+00');
    phoneController = formManager.register('phone',
        onTextChanged: _initData, initialValue: address?.phone);
    streetController = formManager.register('street',
        onTextChanged: _initData, initialValue: address?.street);
    zipCodeController = formManager.register('zipCode',
        onTextChanged: _initData, initialValue: address?.zipCode);
    cityController = formManager.register('city',
        onTextChanged: _initData, initialValue: address?.city);
    stateController = formManager.register('state',
        onTextChanged: _initData, initialValue: address?.state);
    countryController = formManager.register('country',
        onTextChanged: _initData, initialValue: address?.country);
  }

  // 检查表单是否填写完整
  bool isFormComplete() {
    // 可以根据需要检查特定字段
    bool isComplete = formManager.hasAllValues();
    return isComplete;
  }

  AddressModel getAddress() {
    return address!.copyWith(
      addressLabel: formManager.getValue('addressLabel') ?? '',
      deliveryInstructions: formManager.getValue('deliveryInstructions') ?? '',
      name: formManager.getValue('name') ?? '',
      phoneCode: formManager.getValue('phoneCode') ?? '',
      phone: formManager.getValue('phone') ?? '',
      street: formManager.getValue('street') ?? '',
      zipCode: formManager.getValue('zipCode') ?? '',
      city: formManager.getValue('city') ?? '',
      state: formManager.getValue('state') ?? '',
      country: formManager.getValue('country') ?? '',
      isDefault: address?.isDefault ?? false,
      id: address?.id ?? IdUtils.uuid(),
    );
  }

  void addAddress() {
    Get.back(result: getAddress());
  }

  // 释放所有控制器资源
  @override
  void onClose() {
    formManager.dispose();
  }
}
