import 'package:flutter/material.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:flutter_wan/touch_fish/zhihu/answer/view.dart';

import 'question/view.dart';
import 'video/view.dart';

class ZhihuPage extends StatefulWidget {
  const ZhihuPage({Key? key}) : super(key: key);

  @override
  State<ZhihuPage> createState() => _ZhihuPageState();
}

class _ZhihuPageState extends State<ZhihuPage> with TickerProviderStateMixin {
  int tabIndex = 0;
  late TabController tabController;

  late Widget title;
  late Widget body;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        setState(() {
          tabIndex = tabController.index;
        });
      });

    title = TabBar(
      isScrollable: true,
      controller: tabController,
      labelPadding: EdgeInsets.symmetric(horizontal: 14),
      indicatorSize: TabBarIndicatorSize.label,
      tabs: [
        Tab(text: "问"),
        Tab(text: "答"),
        Tab(text: "视频"),
      ],
    );
    body = TabBarView(
      children: [
        QuestionPage(),
        AnswerPage(),
        VideoPage(),
      ],
      controller: tabController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: tabIndex == tabController.length-1 ?Colors.black: AppColors.primary ,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: title,
        ),
        body: body,
      ),
    );
  }
}
