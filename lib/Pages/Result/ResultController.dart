import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:dio_http/dio_http.dart';


class HistoryController extends GetxController {
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
}


/***server address
 * http://10.0.2.2:5000/
 ***/