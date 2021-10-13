import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unmasked_ai/Pages/Home/HomeController.dart';

class HomeUI extends GetView<HomeController>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('HomeUi'),),
      body: const Center(child: Text('Home'),),
    );
  }
}