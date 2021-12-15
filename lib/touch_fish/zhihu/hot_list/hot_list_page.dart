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
    with TickerProviderStateMixin {
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
          child: TabBarView(
            children: HOT_LIST_TYPE.map((e) => QuestionPage(type: e)).toList(),
            controller: tabController,
          ),
        ),
      ],
    );
  }
}
