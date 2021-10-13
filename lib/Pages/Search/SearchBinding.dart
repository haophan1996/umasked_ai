import 'package:get/get.dart';
import 'package:unmasked_ai/Pages/Search/SearchController.dart';


class SearchBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SearchController());
  }

}