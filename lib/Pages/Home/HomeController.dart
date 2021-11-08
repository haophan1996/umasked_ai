import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unmasked_ai/Routes/pages.dart';

class HomeController extends GetxController {
  final imagePicker = ImagePicker();
  late File imageFile;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }


  Future getImageCamera() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);
    imageFile = File(image!.path);
    print(imageFile);
    if (imageFile != null){
      Get.toNamed(Routes.history, arguments: [imageFile]);
    }
  }
}
