import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unmasked_ai/Routes/pages.dart';

class HomeController extends GetxController {
  static HomeController get i => Get.find();
  final imagePicker = ImagePicker();
  TextEditingController inputServerTest = TextEditingController();
  late File imageFile;
  bool isDefaultSvTest = true;
  final String svTestDefault = 'http://10.0.2.2:5000/predict';
  late String svTestInput;

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
    final image =
        await imagePicker.pickImage(source: ImageSource.camera, maxHeight: 400, maxWidth: 400);
    imageFile = File(image!.path);
    if (imageFile != null) {
      Get.toNamed(Routes.history, arguments: [imageFile]);
    }
  }

  Future getImageGallery() async {
    final image =
        await imagePicker.pickImage(source: ImageSource.gallery, maxHeight: 400, maxWidth: 400);
    imageFile = File(image!.path);
    if (imageFile != null) {
      Get.toNamed(Routes.history, arguments: [imageFile]);
    }
  }
}
