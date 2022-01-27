import 'package:flutter/material.dart';
import 'package:flutter_page_view_nested_utils/tabbar_view.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:flutter_wan/touch_fish/zhihu/answer/view.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../eventbus.dart';
import '../../myapp.dart';
import 'hot_list/hot_list_page.dart';
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

  void changePage() {
    if (tabController.index == 0) {
      Get.find<AppLogic>().changeTheme(false);
      bus.emit("video", true);
    } else {
      Get.find<AppLogic>().changeTheme(true);
      bus.emit("video", false);
    }
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(initialIndex: 1, length: 3, vsync: this)
      ..addListener(() {
        changePage();
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
    body = NestedTabBarView(
      children: [
        VideoPage(key: PageStorageKey("视频"),),
        AnswerPage(key: PageStorageKey("推荐"),),
        HotListPage(key: PageStorageKey("热榜"),),
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
