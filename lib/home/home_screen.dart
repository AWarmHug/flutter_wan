import 'package:flutter/material.dart';

import 'nav/navigation_page.dart';
import 'project/project_page.dart';
import 'recommend/recommend_page.dart';
import 'tree/view.dart';
import 'wx_article/wx_article_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final titles = {
    "推荐": RecommendPage(),
    "文章": TreePage(),
    "公众号": WXArticlePage(),
    "导航": NavigationPage(),
    "项目": ProjectPage()
  };

  late final TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: titles.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          tabs: titles.keys
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
          labelPadding: EdgeInsets.all(0),
          controller: _tabController,
          labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),
        ),
      ),
      body: TabBarView(
        children: titles.values.map((e) => e).toList(),
        controller: _tabController,
      ),
    );
  }
}
