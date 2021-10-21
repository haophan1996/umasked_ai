import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late List<CameraDescription> cameras;
  late CameraController controller;
  late CameraDescription selectedCamera;
  late CameraLensDirection lensDirection;
  int cameraSelectIndex = 1;
  bool iniCamera = false;

  final FaceDetector faceDetector = GoogleVision.instance.faceDetector();
  final ImageLabeler imageLabeler = GoogleVision.instance.imageLabeler();
  final TextRecognizer recognizer = GoogleVision.instance.textRecognizer();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    cameras = await availableCameras();
    await toggleCamera();
  }

  toggleCamera() async {
    cameraSelectIndex = cameraSelectIndex == 0 ? 1 : 0;
    selectedCamera = cameras[cameraSelectIndex];
    controller = CameraController(selectedCamera, ResolutionPreset.max);
    controller.initialize().then((value) {
      iniCamera = true;
      update(['awaitForCamera']);

      controller.startImageStream((cameraImage) {
        final WriteBuffer allBytes = WriteBuffer();
        for (Plane plane in cameraImage.planes) {
          allBytes.putUint8List(plane.bytes);
        }
        final bytes = allBytes.done().buffer.asUint8List();

        final Size imageSize = Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());

        faceDetector.processImage(bytes, )
      });
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    controller.dispose();
  }
}
