import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'wx_article_page_controller.dart';

class WXArticlePage extends StatefulWidget {
  const WXArticlePage({Key? key}) : super(key: key);

  @override
  _WXArticlePageState createState() => _WXArticlePageState();
}

class _WXArticlePageState extends State<WXArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("公众号"),
      ),
      body: Container(
        padding: EdgeInsets.all(4),
        child: GetBuilder<WxArticleController>(
          builder: (controller) {
            return GridView.builder(
              itemCount: controller.trees.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Get.toNamed("/tools/wx_article_detail_page",
                        arguments: controller.trees[index]);
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
                    child: Text(controller.trees[index].name!),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //横轴三个子widget
                  childAspectRatio: 1.0 //宽高比为1时，子widget
                  ),
            );
          },
          init: WxArticleController(),
        ),
      ),
    );
  }
}
