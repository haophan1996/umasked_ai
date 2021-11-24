import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'ResultController.dart';

class HistoryUI extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image processing'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                      GetBuilder<HistoryController>(builder: (controller) {
                        return controller.responseBody.isNotEmpty &&
                                controller.responseBody['x'] != 'None'
                            ? CustomPaint(
                                painter: YourDrawRect(),
                              )
                            : Container();
                      })
                    ],
                  ),
                ),
              ),
            ),
            GetBuilder<HistoryController>(builder: (controller) {
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
                    Text(
                      controller.responseBody['x'] == 'None' ? 'Not Detected' : 'Detected',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: controller.responseBody['x'] == 'None'
                              ? Colors.redAccent
                              : Colors.blue,
                          fontSize: Get.textTheme.bodyText1!.fontSize! + 5.0),
                    ),
                    Text(controller.responseBody.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Get.textTheme.bodyText1!.fontSize! + 3.0)),
                    TextButton(onPressed: () async {}, child: const Text('Test'))
                  ],
                );
              }
            }),
          ],
        ),
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
    double x = double.parse(HistoryController.i.responseBody['x']);
    double y = double.parse(HistoryController.i.responseBody['y']);
    double h = double.parse(HistoryController.i.responseBody['h']);
    double w = double.parse(HistoryController.i.responseBody['w']);

    canvas.drawRect(Offset(x, y) & Size(h, w), paint1);

    // canvas.drawRect(
    //   Rect.fromLTRB(
    //       double.parse(HistoryController.i.responseBody['x']),
    //       double.parse(HistoryController.i.responseBody['y']),
    //       double.parse(HistoryController.i.responseBody['h']),
    //       double.parse(HistoryController.i.responseBody['w'])),
    //   Paint()
    //     ..color = const Color(0xFF0099FF).withOpacity(0.5)
    //     ..strokeWidth = 2.0
    //     ..style = PaintingStyle.stroke,
    // );
  }

  @override
  bool shouldRepaint(YourDrawRect oldDelegate) {
    return false;
  }
}
