import 'package:flutter/material.dart';
import 'package:flutter_wan/resource/IconFontIcons.dart';
import 'package:flutter_wan/tools/animation/animation_page.dart';
import 'package:flutter_wan/tools/custom/custom_page.dart';
import 'package:get/get.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage({Key? key}) : super(key: key);

  @override
  _ToolsPageState createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("工具"),
      ),
      body: GridView.count(
        padding: EdgeInsets.only(top: 16),
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: [
          InkWell(
            child: Center(
                child: Column(
              children: [
                Icon(IconFontIcons.iconProject),
                Text("文章"),
              ],
            )),
            onTap: () {
              Get.toNamed("/tools/tree_page");
            },
          ),
          InkWell(
            child: Center(
                child: Column(
              children: [
                Icon(IconFontIcons.iconWechat),
                Text("公众号"),
              ],
            )),
            onTap: () {
              Get.toNamed("/tools/wx_article_page");
            },
          ),
          InkWell(
            child: Center(
                child: Column(
              children: [
                Icon(IconFontIcons.iconWeb),
                Text(
                  "导航",
                ),
              ],
            )),
            onTap: () {
              Get.toNamed("/tools/navigation_page");
            },
          ),
          InkWell(
            child: Center(
                child: Column(
              children: [
                Icon(IconFontIcons.iconProject),
                Text("项目"),
              ],
            )),
            onTap: () {
              Get.toNamed("/tools/project_page");
            },
          ),
          InkWell(
            child: Center(
              child: Column(
                children: [
                  Icon(IconFontIcons.iconProject),
                  Text("自定义控件"),
                ],
              ),
            ),
            onTap: () {
              Get.to(CustomPage());
            },
          ),
          InkWell(
            child: Center(
              child: Column(
                children: [
                  Icon(IconFontIcons.iconProject),
                  Text("动画"),
                ],
              ),
            ),
            onTap: () {
              Get.to(AnimationPage());
            },
          ),
        ],
      ),
    );
  }
}
