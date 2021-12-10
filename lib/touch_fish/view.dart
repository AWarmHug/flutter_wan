import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_wan/resource/IconFontIcons.dart';
import 'package:get/get.dart';

import 'logic.dart';

class TouchFishPage extends StatelessWidget {
  final logic = Get.put<TouchFishLogic>(TouchFishLogic());
  final state = Get.find<TouchFishLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("摸鱼神器"),
      ),
      body: Container(
        child: GridView.count(
          children: [
            InkWell(
              onTap: () {
                Get.toNamed("/touch_fish/zhihu");
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(IconFontIcons.iconZhihu),
                    Text(
                      "知乎",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(IconFontIcons.iconDouyin),
                    Text(
                      "抖音",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(IconFontIcons.iconKaiyan),
                    Text(
                      "开眼",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          ],
          crossAxisCount: 3,
        ),
      ),
    );
  }
}
