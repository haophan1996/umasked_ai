import 'package:get/get.dart';
import 'package:unmasked_ai/Pages/History/HistoryController.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
      Get.put(HistoryController());
  }
}
