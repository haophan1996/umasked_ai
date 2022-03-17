import 'package:get/get.dart';
import 'package:unmasked_ai/Pages/Result/ResultController.dart';

class ResultBinding extends Bindings {
  @override
  void dependencies() {
      Get.put(ResultController());
  }
}
