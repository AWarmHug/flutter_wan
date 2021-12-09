import 'package:flutter/material.dart';

import 'question/view.dart';
import 'video/view.dart';

class ZhihuPage extends StatefulWidget {
  const ZhihuPage({Key? key}) : super(key: key);

  @override
  State<ZhihuPage> createState() => _ZhihuPageState();
}

class _ZhihuPageState extends State<ZhihuPage>
    with SingleTickerProviderStateMixin {
  int tabIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        setState(() {
          tabIndex = tabController.index;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: tabIndex != 1
          ? ThemeData.light()
          : ThemeData.dark().copyWith(
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.black,
              ),
              scaffoldBackgroundColor: Colors.black,
            ),
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            isScrollable: true,
            controller: tabController,
            labelPadding: EdgeInsets.symmetric(horizontal: 14),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(text: "问答"),
              Tab(text: "视频"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            QuestionPage(),
            VideoPage(),
          ],
          controller: tabController,
        ),
      ),
    );
  }
}
