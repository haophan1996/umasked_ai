import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio_http/dio_http.dart';


class HistoryController extends GetxController {
  static HistoryController get i => Get.find();
  late File imagePath;
  var dio = Dio();
  Map responseBody = {};

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      imagePath = Get.arguments[0];
      await processImage();
    } else {
      Get.back();
    }
  }



  Future processImage() async {
    String imageB64 = base64Encode(imagePath.readAsBytesSync());

    var headers = {
      'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'host': '10.0.2.2:5000',
    };

    var body = {
      'file' : imageB64
    };

    dio.options.headers = headers;
    final response =  await dio.post('http://10.0.2.2:5000/predict',data: body);
    responseBody = response.data;
    update();
  }

  // Future<ui.Image> load(File imageP) async{
  //   final bytes = await imageP.readAsBytes();
  //   ByteData data = bytes.buffer.asByteData();
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return fi.image;
  // }
}


/***server address
 * http://10.0.2.2:5000/
 ***/