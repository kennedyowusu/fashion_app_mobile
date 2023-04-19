import 'package:get/get.dart';

class PhoneController extends GetxController {
  var showTextFormField = false.obs;
  var phoneNumber = ''.obs;

  void setShowTextFormField(bool value) {
    showTextFormField.value = value;
  }

  void setPhoneNumber(String value) {
    phoneNumber.value = value;
  }
}
