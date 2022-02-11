import 'package:flutter/material.dart';
import 'package:flutter_wan/resource/IconFontIcons.dart';
import 'package:flutter_wan/tools/animation/animation_page.dart';
import 'package:flutter_wan/tools/custom/custom_page.dart';
import 'package:flutter_wan/tools/future/future_page.dart';
import 'package:flutter_wan/tools/key/key_page.dart';
import 'package:flutter_wan/tools/stream/stream_page.dart';
import 'package:get/get.dart';

import '../route.dart';
import 'dialog/alertdialog.dart';
import 'error/error_page.dart';
import 'widget/demo_page.dart';

class ToolsScreen extends StatefulWidget {
  const ToolsScreen({Key? key}) : super(key: key);

  @override
  _ToolsScreenState createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("工具"),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return GridView.count(
            padding: EdgeInsets.only(top: 16),
            crossAxisCount: constraints.maxWidth < 600 ? 3 : 5,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: [
              TextButton(
                child: Center(
                    child: Column(
                  children: [
                    Icon(IconFontIcons.iconProject),
                    Text("文章"),
                  ],
                )),
                onPressed: () {
                  MyRouter.toNamed(context, "/tools/tree_page");
                },
              ),
              TextButton(
                child: Center(
                    child: Column(
                  children: [
                    Icon(IconFontIcons.iconWechat),
                    Text("公众号"),
                  ],
                )),
                onPressed: () {
                  MyRouter.toNamed(context, "/tools/wx_article_page");
                },
              ),
              TextButton(
                child: Center(
                    child: Column(
                  children: [
                    Icon(IconFontIcons.iconWeb),
                    Text(
                      "导航",
                    ),
                  ],
                )),
                onPressed: () {
                  MyRouter.toNamed(context, "/tools/navigation_page");
                },
              ),
              TextButton(
                child: Center(
                    child: Column(
                  children: [
                    Icon(IconFontIcons.iconProject),
                    Text("项目"),
                  ],
                )),
                onPressed: () {
                  MyRouter.toNamed(context, "/tools/project_page");
                },
              ),
              TextButton(
                child: Center(
                  child: Column(
                    children: [
                      Icon(IconFontIcons.iconProject),
                      Text("Widget"),
                    ],
                  ),
                ),
                onPressed: () {
                  Get.to(WidgetPage());
                },
              ),
              TextButton(
                child: Center(
                  child: Column(
                    children: [
                      Icon(IconFontIcons.iconProject),
                      Text("自定义控件"),
                    ],
                  ),
                ),
                onPressed: () {
                  Get.to(CustomPage());
                },
              ),
              TextButton(
                child: Center(
                  child: Column(
                    children: [
                      Icon(IconFontIcons.iconProject),
                      Text("动画"),
                    ],
                  ),
                ),
                onPressed: () {
                  Get.to(AnimationPage());
                },
              ),
              TextButton(
                child: Center(
                  child: Column(
                    children: [
                      Icon(IconFontIcons.iconProject),
                      Text("Key"),
                    ],
                  ),
                ),
                onPressed: () {
                  Get.to(KeyPage());
                },
              ),
              TextButton(
                child: Center(
                  child: Column(
                    children: [
                      Icon(IconFontIcons.iconProject),
                      Text("拦截Error信息"),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ErrorPage(),
                      ));
                },
              ),
              TextButton(
                child: Center(
                  child: Column(
                    children: [
                      Icon(IconFontIcons.iconProject),
                      Text("Future"),
                    ],
                  ),
                ),
                onPressed: () {
                  Get.to(FuturePage());
                },
              ),
              TextButton(
                child: Center(
                  child: Column(
                    children: [
                      Icon(IconFontIcons.iconProject),
                      Text("Stream"),
                    ],
                  ),
                ),
                onPressed: () {
                  Get.to(StreamPage());
                },
              ),
              TextButton(
                child: Center(
                  child: Column(
                    children: [
                      Icon(IconFontIcons.iconProject),
                      Text("AlertDialog"),
                    ],
                  ),
                ),
                onPressed: () {
                  Get.to(AlertDialogScreen());
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
