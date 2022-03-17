import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unmasked_ai/Pages/Home/HomeController.dart';
import 'package:card_swiper/card_swiper.dart';

class HomeUI extends GetView<HomeController> {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'unmasked AI',
          style: TextStyle(color: Colors.black),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                    content: Column(
                      children: [
                        TextField(
                          controller: controller.inputServerTest,
                          autofocus: true,
                          decoration: const InputDecoration.collapsed(hintText: 'Your server Test'),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () => Get.back(),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.red),
                                )),
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  controller.isDefaultSvTest = true;
                                  controller.inputServerTest.clear();
                                  Get.back();
                                },
                                child: const Text(
                                  'Default',
                                  style: TextStyle(color: Colors.deepOrange),
                                )),
                            const Spacer(),
                            TextButton(
                                onPressed: () {
                                  if (controller.inputServerTest.text.length < 5) {
                                    controller.isDefaultSvTest = true;
                                    Get.defaultDialog(
                                        title: 'Hmmm! Ur host is too short',
                                        middleText: 'Press anywhere to dismiss');
                                  } else {
                                    controller.isDefaultSvTest = false;
                                    controller.svTestInput = controller.inputServerTest.text;
                                    Get.back();
                                  }
                                },
                                child: const Text('Confirm'))
                          ],
                        )
                      ],
                    ),
                    title: 'API test');
              },
              icon: const Icon(
                Icons.web_sharp,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: SizedBox(
                height: Get.height / 2,
                child: Swiper(
                  autoplay: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            child: Image.asset(
                              'assets/homeImages/Picture$index.png',
                            ),
                            alignment: Alignment.center,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              child: Text(
                                controller.labelImg[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.textTheme.headline6!.fontSize),
                              ),
                              decoration: const BoxDecoration(
                                color: Color(0xFFEEEEEE),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: 5,
                  viewportFraction: 0.8,
                  scale: 0.9,
                  itemWidth: 300.0,
                  itemHeight: Get.height / 2,
                  layout: SwiperLayout.STACK,
                ),
              ),
            ), // Image swiper
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xFFEEEEEE), borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Face scanner',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Get.textTheme.headline6!.fontSize),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              child: IconButton(
                                  onPressed: () async {
                                    await controller.getImageCamera();
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo_sharp,
                                    size: 30,
                                  ))),
                          Center(
                            child: IconButton(
                              onPressed: () async {
                                await controller.getImageGallery();
                              },
                              icon: const Icon(Icons.add_photo_alternate_outlined, size: 30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ), // Face scanner
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xFFEEEEEE), borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Summary',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Get.textTheme.headline6!.fontSize),
                      ),
                    ),
                    // Text('\n\nNo results\n')
                    SizedBox(
                      height: 90,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Image.asset(
                                'assets/emoji/${controller.labelEmoji.elementAt(index)}.png',
                                width: controller.emojiSize,
                                height: controller.emojiSize,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5, right: 5),
                                child: Text(controller.labelEmoji.elementAt(index)),
                              ),
                              Text('0')
                            ],
                          );
                        },
                      ),
                    ),
                    Text('Total: ---%\n')
                  ],
                ),
              ),
            ), // Summary
          ],
        ),
      ),
    );
  }
}
