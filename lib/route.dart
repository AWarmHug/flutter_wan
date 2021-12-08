import 'package:flutter_wan/login/login_home.dart';
import 'package:flutter_wan/login/reg_home.dart';
import 'package:flutter_wan/mine/collect/collect_page.dart';
import 'package:flutter_wan/search/content/search_content_home.dart';
import 'package:flutter_wan/search/search_home.dart';
import 'package:flutter_wan/tools/nav/navigation_page.dart';
import 'package:flutter_wan/tools/project/view.dart';
import 'package:flutter_wan/tools/wx_article/detail/view.dart';
import 'package:flutter_wan/tools/wx_article/wx_article_page.dart';
import 'package:flutter_wan/touch_fish/view.dart';
import 'package:flutter_wan/touch_fish/zhihu/home/view.dart';
import 'package:flutter_wan/web/home.dart';
import 'package:get/get.dart';

import 'tools/tree/view.dart';

final pages = <GetPage>[
  GetPage(
    name: "/douyin",
    page: () => TouchFishPage(),
  ),
  GetPage(
    name: "/search",
    page: () => SearchHome(),
  ),
  GetPage(
    name: "/search/content",
    page: () => SearchContentHome(),
  ),
  GetPage(
    name: "/login/reg",
    page: () => RegHome(),
  ),
  GetPage(
    name: "/login/login",
    page: () => LoginHome(),
  ),
  GetPage(
    name: "/web",
    page: () => WebHome(),
  ),
]
  ..addAll(touchFishPages)
  ..addAll(toolsPages)
  ..addAll(minePages);

List<GetPage> touchFishPages = [
  GetPage(
    name: "/touch_fish/zhihu/home",
    page: () => HomePage(),
  ),
];

List<GetPage> toolsPages = [
  GetPage(
    name: "/tools/wx_article_page",
    page: () => WXArticlePage(),
  ),
  GetPage(
    name: "/tools/wx_article_detail_page",
    page: () => WxArticleDetailPage(),
  ),
  GetPage(
    name: "/tools/navigation_page",
    page: () => NavigationPage(),
  ),
  GetPage(
    name: "/tools/project_page",
    page: () => ProjectPage(),
  ),
  GetPage(
    name: "/tools/tree_page",
    page: () => TreePage(),
  ),
];

List<GetPage> minePages = [
  GetPage(
    name: "/mine/collect",
    page: () => CollectPage(),
  ),
];
