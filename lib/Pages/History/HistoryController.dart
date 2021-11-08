import 'dart:io';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  late File imagePath;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      imagePath = Get.arguments[0];
    } else
      Get.back();
  }
}
