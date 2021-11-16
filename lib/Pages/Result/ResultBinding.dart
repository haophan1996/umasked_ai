import 'package:get/get.dart';
import 'package:unmasked_ai/Pages/Result/ResultController.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
      Get.put(HistoryController());
  }
}
