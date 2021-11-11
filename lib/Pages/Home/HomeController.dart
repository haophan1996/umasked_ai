import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unmasked_ai/Routes/pages.dart';

class HomeController extends GetxController {
  final imagePicker = ImagePicker();
  late File imageFile;
  List labelImg = [
    'Front End',
    'Example: Educators',
    'Neural network',
    'Training Data',
    'Implementation'
  ];

  @override
  void onInit() {
    super.onInit();
  }

  Future getImageCamera() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    imageFile = File(image!.path);
    if (imageFile != null) {
      Get.toNamed(Routes.history, arguments: [imageFile]);
    }
  }

  Future getImageGallery() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    imageFile = File(image!.path);
    if (imageFile != null) {
      Get.toNamed(Routes.history, arguments: [imageFile]);
    }
  }
}
