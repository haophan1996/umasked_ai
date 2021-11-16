import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: Container(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.file(controller.imagePath),
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
                    'Detected',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: Get.textTheme.bodyText1!.fontSize! + 5.0),
                  ),
                  Text(controller.responseBody.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Get.textTheme.bodyText1!.fontSize! + 3.0))
                ],
              );
            }
          }),
        ],
      ),
    );
  }
}
