import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'ResultController.dart';

class ResultUI extends GetView<ResultController> {
  const ResultUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.blue,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: Stack(
        children: [
          GetBuilder<ResultController>(builder: (controller) {
            return Container(
              constraints: const BoxConstraints.expand(),
              color: controller.getEmoji(controller.responseBody) == 'nil'
                  ? Colors.grey.shade200
                  : Colors.blue,
            );
          }),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: Container(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Stack(
                      children: [
                        Image.file(controller.imagePath),
                        GetBuilder<ResultController>(builder: (controller) {
                          return controller.responseBody.isNotEmpty &&
                                  controller.responseBody['x'] != 'None'
                              ? CustomPaint(
                                  painter: YourDrawRect(),
                                )
                              : SizedBox();
                        })
                      ],
                    ),
                  ),
                ),
              ),
              GetBuilder<ResultController>(builder: (controller) {
                if (controller.responseBody.isEmpty == true) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Processing\t\t\t',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Get.textTheme.headline6!.fontSize)),
                      const CupertinoActivityIndicator()
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          controller.responseBody['x'] == 'None' ? 'Not Detected' : 'Detected',
                          style: TextStyle(fontSize: Get.textTheme.bodyText1!.fontSize! + 5.0),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Image.asset(
                                "assets/emoji/${controller.getEmoji(controller.responseBody)}.png"),
                          ),
                          Text(
                            controller.getEmoji(controller.responseBody) == 'nil'
                                ? ''
                                : controller.getEmoji(controller.responseBody),
                            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  );
                }
              }),
            ],
          )
        ],
      ),
    );
  }
}

class YourDrawRect extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) async {
    var paint1 = Paint()
      ..color = const Color(0xFF0099FF).withOpacity(0.5)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    double x = double.parse(ResultController.i.responseBody['x']);
    double y = double.parse(ResultController.i.responseBody['y']);
    double h = double.parse(ResultController.i.responseBody['h']);
    double w = double.parse(ResultController.i.responseBody['w']);
    canvas.drawRect(Offset(x, y) & Size(h, w), paint1);
  }

  @override
  bool shouldRepaint(YourDrawRect oldDelegate) {
    return false;
  }
}
