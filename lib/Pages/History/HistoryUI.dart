import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'HistoryController.dart';


class HistoryUI extends GetView<HistoryController>{

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        body: Center(
          child: Text('History'),
        ),
     );
  }


}