import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan/login/login_home.dart';
import 'package:flutter_wan/login/reg_home.dart';
import 'package:flutter_wan/mine/collect/collect_page.dart';
import 'package:flutter_wan/search/content/search_content_home.dart';
import 'package:flutter_wan/search/search_home.dart';
import 'package:flutter_wan/tools/nav/navigation_page.dart';
import 'package:flutter_wan/tools/navigator/unknown_page.dart';
import 'package:flutter_wan/tools/project/view.dart';
import 'package:flutter_wan/tools/wx_article/detail/view.dart';
import 'package:flutter_wan/tools/wx_article/wx_article_page.dart';
import 'package:flutter_wan/web/home.dart';
import 'package:get/get.dart';

import 'home/view.dart';
import 'main/screen.dart';
import 'tools/tree/view.dart';
import 'touch_fish/zhihu/answer/answer_detail/answer_detail_view.dart';
import 'touch_fish/zhihu/answer/answer_list/answer_list_view.dart';
import 'touch_fish/zhihu/view.dart';

final pages = <GetPage>[
  GetPage(
    name: "/",
    page: () => MainScreen(),
  ),
  GetPage(
    name: "/search",
    page: () => SearchScreen(),
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
    name: "/touch_fish/zhihu",
    page: () => ZhihuPage(),
  ),
  GetPage(
    name: "/touch_fish/zhihu/video",
    page: () => HomePage(),
  ),
  GetPage(
    name: "/touch_fish/zhihu/answer_detail",
    page: () => AnswerDetailPage(),
  ),
  GetPage(
    name: "/touch_fish/zhihu/answer_list",
    page: () => AnswerListPage(),
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

class _MyRouter {
  static MyRouterDelegate of(BuildContext context) {
    RouterDelegate routerDelegate = Router.of(context).routerDelegate;
    assert(routerDelegate is MyRouterDelegate, "");
    return routerDelegate as MyRouterDelegate;
  }
}

final MyRouter = _MyRouter();

extension RouteExt on _MyRouter {
  void toNamed<T>(BuildContext context, String name) {
    RouterDelegate routerDelegate = Router.of(context).routerDelegate;
    if (routerDelegate is MyRouterDelegate) {
      _MyRouter.of(context).push(name);
    } else {
      Get.toNamed(name);
    }
  }

  void back(BuildContext context) {
    RouterDelegate routerDelegate = Router.of(context).routerDelegate;
    if (routerDelegate is MyRouterDelegate) {
      _MyRouter.of(context).popRoute();
    } else {
      Get.back();
    }
  }
}

class MyRouteInformationParser extends RouteInformationParser<String> {
  @override
  Future<String> parseRouteInformation(RouteInformation routeInformation) {
    return SynchronousFuture(routeInformation.location ?? "/");
  }

  @override
  RouteInformation restoreRouteInformation(String configuration) {
    return RouteInformation(location: configuration);
  }
}

class MyRouterDelegate extends RouterDelegate<String>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<String> {
  List<Page> routePages = [];

  void push(String route) {
    routePages.add(parseRoute(route));
    notifyListeners();
  }

  Page parseRoute(String name) {
    var pageBuilder = pages.firstWhereOrNull((element) => element.name == name);

    Widget widget;
    if (pageBuilder != null) {
      widget = pageBuilder.page();
    } else {
      widget = UnknownScreen();
    }
    return MaterialPage(key: ValueKey(name), child: widget);
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    if (routePages.isNotEmpty) {
      if (routePages.last.name == route.settings.name) {
        routePages.remove(route.settings);
        notifyListeners();
      }
    }
    return route.didPop(result);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: List.unmodifiable(routePages),
      onPopPage: _onPopPage,
    );
  }

  @override
  GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

  @override
  String? get currentConfiguration {
    return routePages.last.name;
  }

  @override
  Future<bool> popRoute() {
    if (canPop()) {
      routePages.removeLast();
      notifyListeners();
      return Future.value(true);
    }
    SystemNavigator.pop();
    return Future.value(true);
  }

  bool canPop(){
    return routePages.length>1;
  }

  @override
  Future<void> setNewRoutePath(String configuration) {
    debugPrint("configuration===${configuration}");
    routePages
      ..clear()
      ..add(parseRoute(configuration));

    return SynchronousFuture<void>(null);
  }
}
