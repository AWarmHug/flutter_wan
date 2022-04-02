import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan/login/login_home.dart';
import 'package:flutter_wan/login/reg_home.dart';
import 'package:flutter_wan/mine/collect/collect_page.dart';
import 'package:flutter_wan/search/page.dart';
import 'package:flutter_wan/todo/page.dart';
import 'package:flutter_wan/tools/navigator/unknown_page.dart';
import 'package:flutter_wan/web/web_srceen.dart';
import 'package:get/get.dart';

import 'data/tree.dart';
import 'home/nav/navigation_page.dart';
import 'home/project/project_page.dart';
import 'home/tree/view.dart';
import 'home/wx_article/detail/view.dart';
import 'home/wx_article/wx_article_page.dart';
import 'main/screen.dart';
import 'touch_fish/page.dart';

final pages = <GetPage>[
  GetPage(
    name: "/",
    page: () => MainScreen(),
  ),
  GetPage(
    name: "/login/reg",
    page: () => RegHome(),
  ),
  GetPage(
    name: "/login/login",
    page: () => LoginHome(),
  ),
  // GetPage(
  //   name: "/web",
  //   page: () => WebHome(),
  // ),
]
  ..addAll(toolsPages)
  ..addAll(minePages);

List<GetPage> toolsPages = [
  GetPage(
    name: "/tools/wx_article_page",
    page: () => WXArticlePage(),
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
  void to<T>(BuildContext context, Widget child) {
    _MyRouter.of(context).pushWidget(child);
  }

  void toNamed<T>(BuildContext context, String name, {dynamic arguments}) {
    RouterDelegate routerDelegate = Router.of(context).routerDelegate;
    if (routerDelegate is MyRouterDelegate) {
      _MyRouter.of(context).push(name, arguments: arguments);
    } else {
      Get.toNamed(name, arguments: arguments);
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

  void push(String route, {dynamic arguments}) {
    routePages.add(parseRoute(route, arguments: arguments));
    notifyListeners();
  }

  void pushWidget(Widget widget) {
    Page page = MaterialPage(child: widget);
    routePages.add(page);
    notifyListeners();
  }

  Page parseRoute(String name, {dynamic arguments}) {
    final uri = Uri.parse(name);
    String path = uri.path;
    String pathSegment1 =
        (uri.pathSegments.isNotEmpty) ? uri.pathSegments[0] : "/";

    switch (pathSegment1) {
      case "touch_fish":
        return TouchFishPage(name: name, arguments: arguments);
      case "todo":
        return TodoPage(name: name, arguments: arguments);
      case "search":
        return SearchPage(name: name, arguments: arguments);

      default:
        var pageBuilder =
            pages.firstWhereOrNull((element) => element.name == name);

        Widget widget;
        if (pageBuilder != null) {
          widget = pageBuilder.page();
        } else {
          if (name == "/web") {
            debugPrint("name = ${name} ,  arguments = ${arguments}");
            widget = WebScreen(
              webInfo: arguments as WebInfo,
            );
          } else if (name == "/tools/wx_article_detail_page") {
            widget = WxArticleDetailScreen(tree: arguments as Tree);
          } else {
            widget = UnknownScreen();
          }
        }

        return MaterialPage(
            key: ValueKey(name), arguments: arguments, child: widget);
    }
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

  bool canPop() {
    return routePages.length > 1;
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
