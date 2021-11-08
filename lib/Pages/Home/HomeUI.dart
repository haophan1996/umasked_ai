import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unmasked_ai/Pages/Home/HomeController.dart';

class HomeUI extends GetView<HomeController> {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('unmasked AI'),
      ),
      body: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: IconButton(
                      onPressed: () async {
                        await controller.getImageCamera();
                      },
                      icon: const Icon(Icons.add_a_photo_sharp, size: 30,))),
              Center(
                child: IconButton(
                  onPressed: () async {},
                  icon: const Icon(Icons.add_photo_alternate_outlined, size: 30),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
