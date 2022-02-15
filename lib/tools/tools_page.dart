import 'package:flutter/material.dart';
import 'package:flutter_wan/resource/IconFontIcons.dart';
import 'package:flutter_wan/tools/animation/animation_page.dart';
import 'package:flutter_wan/tools/custom/custom_page.dart';
import 'package:flutter_wan/tools/future/future_page.dart';
import 'package:flutter_wan/tools/key/key_page.dart';
import 'package:flutter_wan/tools/stream/stream_page.dart';

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
                      Text("Widget"),
                    ],
                  ),
                ),
                onPressed: () {
                  MyRouter.to(context, WidgetPage());
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
                  MyRouter.to(context, CustomPage());
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
                  MyRouter.to(context, AnimationPage());
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
                  MyRouter.to(context, KeyPage());
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
                  MyRouter.to(context, ErrorPage());
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
                  MyRouter.to(context, FuturePage());
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
                  MyRouter.to(context, StreamPage());
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
                  MyRouter.to(context, AlertDialogScreen());
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
