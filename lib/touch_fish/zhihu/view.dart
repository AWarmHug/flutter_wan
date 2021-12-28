import 'package:flutter/material.dart';
import 'package:flutter_wan/main.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:flutter_wan/touch_fish/zhihu/answer/view.dart';
import 'package:flutter_wan/widget/player.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import 'hot_list/hot_list_page.dart';
import 'hot_list/view.dart';
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
    super.initState();
    tabController = TabController(initialIndex: 1, length: 3, vsync: this)
      ..addListener(() {
        setState(() {
          Get.find<AppLogic>().changeTheme(tabController.index != 0);
        });
      });

    title = Center(
      child: TabBar(
        controller: tabController,
        labelPadding: EdgeInsets.symmetric(horizontal: 8),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.white,
        isScrollable: true,
        labelStyle: AppTextStyles.white_14.bold,
        tabs: [
          Tab(text: "视频"),
          Tab(text: "推荐"),
          Tab(text: "热榜"),
        ],
      ),
    );
    body = TabBarView(
      children: [
        VideoPage(),
        AnswerPage(),
        HotListPage(),
      ],
      controller: tabController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: title,
      ),
      body: body,
    );
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  void deactivate() {
    super.deactivate();
    debugPrint("-----deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("-----ispose");
  }
}
