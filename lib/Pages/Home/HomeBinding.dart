import 'package:get/get.dart';
import 'package:unmasked_ai/Pages/Home/HomeController.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
     Get.put(HomeController());
  }


}

