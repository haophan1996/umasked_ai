import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:dio_http/dio_http.dart';
import 'package:unmasked_ai/Pages/Home/HomeController.dart';

class ResultController extends GetxController {
  static ResultController get i => Get.find();
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
      //'host': 'b3f1-2601-196-4702-840-963-c89a-47ee-3d72.ngrok.io',
    };

    var body = {'file': imageB64};

    dio.options.headers = headers;
    final response = await dio.post(
        HomeController.i.isDefaultSvTest == false && HomeController.i.svTestInput.length > 10
            ? HomeController.i.svTestInput
            : HomeController.i.svTestDefault,
        data: body);

    responseBody = response.data;
    update();
  }

  getEmoji(Map data){
    if (data['x'] == 'None' && data['h'] == 'None' && data['w'] == 'None' && data['y'] == 'None' ){
      return 'nil';
    } else {
      return data['class_name'];
    }
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
