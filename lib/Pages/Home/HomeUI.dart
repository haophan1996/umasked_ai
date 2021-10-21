import 'package:camera/camera.dart';
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
      body: GetBuilder<HomeController>(
        id: 'awaitForCamera',
        builder: (controller) {
          return controller.iniCamera == false
              ? const Center(child: Text('wait for camera'))
              : Column(
                  children: [
                    Expanded(
                      child: Container(
                        constraints: const BoxConstraints.expand(),
                        child: AspectRatio(
                          aspectRatio: controller.controller.value.aspectRatio,
                          child: CameraPreview(controller.controller),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        color: Colors.black,
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    if (controller.controller != null) await controller.controller.dispose();
                                    await controller.toggleCamera();
                                  },
                                  icon: const Icon(Icons.flip_camera_android, size: 30, color: Colors.white)),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.photo_camera_rounded, size: 30, color: Colors.white),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
