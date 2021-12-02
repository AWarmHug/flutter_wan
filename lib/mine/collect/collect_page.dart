import 'package:flutter/material.dart';
import 'package:flutter_wan/mine/collect/web/view.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:get/get.dart';

import 'article/view.dart';

class CollectPage extends StatefulWidget {
  @override
  _CollectPageState createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("我的收藏"),
         ),
      body: Column(
        children: [
          TabBar(
            controller: _controller,
            labelColor: AppColors.primary,
            unselectedLabelColor:  AppColors.black,
            indicatorWeight: 1,
            isScrollable: true,
            labelStyle: AppTextStyles.white_16_bold,
            unselectedLabelStyle: AppTextStyles.light_14.size(16),
            indicatorSize: TabBarIndicatorSize.label,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 2,
                style: BorderStyle.solid
              )
            ),
            indicatorColor: AppColors.primary,
            labelPadding: EdgeInsets.only(left: 8, right: 8),
            tabs: [
              Tab(
                text: "文章",
              ),
              Tab(
                text: "网站",
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: TabBarView(
              children: [
                ArticlePage(),
                WebPage(),
              ],
              controller: _controller,
            ),
          ),
        ],
      ),
    );
  }
}
