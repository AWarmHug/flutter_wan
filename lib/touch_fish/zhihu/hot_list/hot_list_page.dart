import 'package:flutter/material.dart';
import 'package:flutter_wan/http.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';

import 'view.dart';

class HotListPage extends StatefulWidget {
  const HotListPage({Key? key}) : super(key: key);

  @override
  _HotListPageState createState() => _HotListPageState();
}

class _HotListPageState extends State<HotListPage>
    with TickerProviderStateMixin ,AutomaticKeepAliveClientMixin{
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: HOT_LIST_TYPE.length, vsync: this)
      ..addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          isScrollable: true,
          controller: tabController,
          labelPadding: EdgeInsets.symmetric(horizontal: 8),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Theme.of(context).primaryColor,
          labelStyle: AppTextStyles.black_12.bold,
          unselectedLabelColor: Colors.black54,
          padding: EdgeInsets.symmetric(vertical: 8),
          indicator: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          tabs: HOT_LIST_TYPE
              .map((e) => Tab(
                    text: e.item1,
                    height: 20,
                  ))
              .toList(),
        ),
        Expanded(
          child: NotificationListener(
            child: TabBarView(
              children:
                  HOT_LIST_TYPE.map((e) => QuestionPage(type: e)).toList(),
              controller: tabController,
            ),
            onNotification: (notification) {
              debugPrint("-------notification = ${notification}");
              if (notification is ScrollUpdateNotification) {
                debugPrint(
                    "-------notification-ScrollUpdateNotification = ${notification.scrollDelta}");
              } else if (notification is ScrollMetricsNotification) {
                var metrics = notification.metrics;
                if (metrics is PageMetrics) {
                  debugPrint(
                      "-------notification-ScrollMetricsNotification = 滚动位置 ${metrics.extentBefore}");
                  debugPrint(
                      "-------notification-ScrollMetricsNotification = 页面宽度 ${metrics.extentInside}");
                  debugPrint(
                      "-------notification-ScrollMetricsNotification = 剩余 ${metrics.extentAfter}");
                  debugPrint(
                      "-------notification-ScrollMetricsNotification = pixels ${metrics.pixels}");
                }
              }
              return true;
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}