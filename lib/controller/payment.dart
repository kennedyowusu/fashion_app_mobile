import 'package:get/get.dart';

class PaymentController extends GetxController {
  var isExpanded = false.obs;

  void toggle() {
    isExpanded.value = !isExpanded.value;
  }
}
