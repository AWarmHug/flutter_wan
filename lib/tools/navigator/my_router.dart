import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/tools/navigator/main.dart';
import 'package:flutter_wan/tools/navigator/stack.dart';
import 'package:flutter_wan/tools/navigator/unknown_page.dart';
import 'package:flutter_wan/tools/navigator/user_page.dart';

import 'home_page.dart';

class MyRouter {
  static MyRouterDelegate of(BuildContext context) {
    RouterDelegate routerDelegate = Router.of(context).routerDelegate;
    assert(routerDelegate is MyRouterDelegate, "");
    return routerDelegate as MyRouterDelegate;
  }
}

abstract class RouterPage extends Page {
  RouterPage({required String name, Object? arguments})
      : super(key: ValueKey("${name}"), name: name, arguments: arguments);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: createWidget,
    );
  }

  @factory
  Widget createWidget(BuildContext context);
}

class MyRouteInformationParser extends RouteInformationParser<String> {
  @override
  Future<String> parseRouteInformation(RouteInformation routeInformation) {
    return SynchronousFuture(routeInformation.location!);
  }

  @override
  RouteInformation restoreRouteInformation(String configuration) {
    return RouteInformation(location: configuration);
  }
}

class MyRouterDelegate extends RouterDelegate<String>
    with PopNavigatorRouterDelegateMixin, ChangeNotifier {
  TStack<String> _stack = TStack();

  void push(String route) {
    _stack.push(route);
    notifyListeners();
  }

  Page parseRoute(String name) {
    final uri = Uri.parse(name);
    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return MaterialPage(child: MainScreen());
    } else {
      switch (uri.pathSegments[0]) {
        case "home":
          return HomePage(name: name);
        case "user":
          return UserPage(name);
      }
    }
    return UnKnownPage();
  }

  List<Page> get pages {
    return _stack.obj.map((name) {
      return parseRoute(name);
    }).toList();
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    if (_stack.isNotEmpty) {
      if (_stack.last == route.settings.name) {
        _stack.pop(route.settings.name);
        notifyListeners();
      }
    }
    return route.didPop(result);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: _onPopPage,
    );
  }

  @override
  // GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  String? get currentConfiguration {
    return _stack.last;
  }

  @override
  Future<void> setNewRoutePath(String configuration) {
    _stack
      ..clear()
      ..push(configuration);
    return SynchronousFuture<void>(null);
  }
}
