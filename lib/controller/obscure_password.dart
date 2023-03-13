import 'package:get/get.dart';

class ObscurePassword extends GetxController {
  bool obscurePass = true;

  void toggleObscurePass() {
    obscurePass = !obscurePass;
    update();
  }
}
