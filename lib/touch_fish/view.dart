import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class TouchFishPage extends StatelessWidget {
  final logic = Get.put<TouchFishLogic>(TouchFishLogic());
  final state = Get.find<TouchFishLogic>().state;

  final items = ["知乎"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("摸鱼神器"),
      ),
      body: Container(
        child: GridView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Get.toNamed("/touch_fish/zhihu/home");
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(
                    100,
                    Random().nextInt(255),
                    Random().nextInt(255),
                    Random().nextInt(255),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.all(4),
                padding: EdgeInsets.all(8),
                child: Text(items[index]),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, //横轴三个子widget
              childAspectRatio: 1.0 //宽高比为1时，子widget
              ),
        ),
      ),
    );
  }
}
