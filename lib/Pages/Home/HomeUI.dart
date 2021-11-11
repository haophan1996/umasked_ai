import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unmasked_ai/Pages/Home/HomeController.dart';
import 'package:card_swiper/card_swiper.dart';

class HomeUI extends GetView<HomeController> {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('unmasked AI'),
      ),
      body: Column(
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
                      color: Colors.white,
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
                              color: Colors.white,
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
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
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
                    padding: EdgeInsets.only(top: 10),
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
                            icon: const Icon(Icons.add_photo_alternate_outlined,
                                size: 30),
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
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
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
                  Text('\n\nNo results\n')
                ],
              ),
            ),
          ), // Summary
        ],
      ),
    );
  }
}
