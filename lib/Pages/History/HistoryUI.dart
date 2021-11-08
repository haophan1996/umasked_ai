import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'HistoryController.dart';

class HistoryUI extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image processing'),
      ),
      body: Column(
        children: [
          Image.file(controller.imagePath),
          Text('Detect 1 student confused'),
          Text('This will send image to backend to process '),
          CupertinoActivityIndicator()
        ],
      ),
    );
  }
}
