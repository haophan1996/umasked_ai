import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Routes/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 200),
      popGesture: true,
      getPages: AppPage.pages,
      initialRoute: AppPage.initial,
    );
  }
}