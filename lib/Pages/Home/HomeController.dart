import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unmasked_ai/Routes/pages.dart';

class HomeController extends GetxController {
  static HomeController get i => Get.find();
  final imagePicker = ImagePicker();
  final emojiSize = 40.0;
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

  List labelEmoji = [
    'Frustrated',
    'Bored',
    'Nervous',
    'Happy',
    'Neutral',
    'Sad',
    'Surprise',
  ];

  List summary = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0, // count for total
  ];

  @override
  void onInit() {
    super.onInit();
  }

  Future getImageCamera() async {
    final image = await imagePicker.pickImage(
        source: ImageSource.camera,
        maxHeight: 400,
        maxWidth: 400,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 100);

    imageFile = File(image!.path);

    //convert to png
    var img = decodeImage(imageFile.readAsBytesSync());
    File(image.path).writeAsBytesSync(encodePng(img!));

    if (imageFile != null) {
      Get.toNamed(Routes.history, arguments: [imageFile]);
    }
  }

  Future getImageGallery() async {
    final image =
        await imagePicker.pickImage(source: ImageSource.gallery, maxHeight: 300, maxWidth: 300);
    imageFile = File(image!.path);

    //convert to png
    var img = decodeImage(imageFile.readAsBytesSync());
    File(image.path).writeAsBytesSync(encodePng(img!));

    if (imageFile != null) {
      Get.toNamed(Routes.history, arguments: [imageFile]);
    }
  }
}
