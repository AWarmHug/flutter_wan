import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async => runApp(App());

class App extends StatelessWidget {
  MainRouterDelegate mainRouterDelegate = MainRouterDelegate();
  MainRouteInformationParser mainRouteInformationParser =
  MainRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Codelessly',
      routerDelegate: mainRouterDelegate,
      routeInformationParser: mainRouteInformationParser,
      debugShowCheckedModeBanner: false,
    );
  }
}

/// The RouteDelegate defines application specific behaviors of how the router
/// learns about changes in the application state and how it responds to them.
/// It listens to the RouteInformation Parser and the app state and builds the Navigator with
/// the current list of pages (immutable object used to set navigator's history stack).
class MainRouterDelegate extends RouterDelegate<MainRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MainRoute> {
  //This is the state of the navigator widget (in build method).
  GlobalKey<NavigatorState>  navigatorKey = GlobalKey<NavigatorState>();

  /// Internal backstack and pages representation.
  List<MainRoute> _mainRoutes = [];
  List<MainRoute> get mainRoutes => _mainRoutes;

  bool _canPop = true;
  bool get canPop {
    if (_canPop == false) return false;

    return _mainRoutes.isNotEmpty;
  }

  set canPop(bool canPop) => _canPop = canPop;

  /// CurrentConfiguration detects changes in the route information
  /// It helps complete the browser history and enables browser back and forward buttons.
  MainRoute? get currentConfiguration =>
      mainRoutes.isNotEmpty ? mainRoutes.last : null;

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        pages: [
          if (mainRoutes.isEmpty)
            MainPageBuilder(context, MainRoute.home()).page,
          for (MainRoute path in mainRoutes)
            MainPageBuilder(context, path).page,
        ],
        onPopPage: (route, result) {
          print('Pop Page');
          if (!route.didPop(result)) {
            return false;
          }
          if (canPop) {
            pop();
          }
          return true;
        });
  }

  @override
  Future<void> setNewRoutePath(MainRoute path) async {
    print('Set New Route Path: ${path.name}');
    if (_canPop == false) return SynchronousFuture(null);
    if (path == currentConfiguration) return SynchronousFuture(null);
    _mainRoutes = _setNewRouteHistory(_mainRoutes, path);
    print('Main Routes: $mainRoutes');
    notifyListeners();
    return SynchronousFuture(null);
  }

  @override
  Future<bool> popRoute() {
    print('Pop Route');
    return super.popRoute();
  }

  /// Updates route path history.
  ///
  /// In a browser, forward and backward navigation
  /// is indeterminate and a custom path history stack
  /// implementation is needed.
  /// When a [newRoute] is added, check the existing [routes]
  /// to see if the path already exists. If the path exists,
  /// remove all path entries on top of the path.
  /// Otherwise, add the new path to the path list.
  List<MainRoute> _setNewRouteHistory(
      List<MainRoute> routes, MainRoute newRoute) {
    List<MainRoute> pathsHolder = [];
    pathsHolder.addAll(routes);
    // Check if new path exists in history.
    for (MainRoute path in routes) {
      // If path exists, remove all paths on top.
      if (path == newRoute) {
        int index = routes.indexOf(path);
        int count = routes.length;
        for (var i = index; i < count - 1; i++) {
          pathsHolder.removeLast();
        }
        return pathsHolder;
      }
    }

    // Add new path to history.
    pathsHolder.add(newRoute);

    return pathsHolder;
  }

  void push(MainRoute path) {
    assert(path != null);
    _mainRoutes.add(path);
    notifyListeners();
  }

  void pop() {
    _mainRoutes.removeLast();
    notifyListeners();
  }
}

/// The RouteInformationParser takes the RouteInformation
/// from a RouteInformationProvider and parses it into a user-defined data type.
class MainRouteInformationParser extends RouteInformationParser<MainRoute> {
  @override
  Future<MainRoute> parseRouteInformation(
      RouteInformation routeInformation) async {
    final Uri uri = Uri.parse(routeInformation.location!);
    return SynchronousFuture(MainRoute.parse(uri));
  }

  @override
  RouteInformation restoreRouteInformation(MainRoute path) {
    return RouteInformation(location: path.uri!.path);
  }
}

class MainRoute {
  final String? name;
  final Uri? uri;
  final dynamic? data;
  final Object? state;

  const MainRoute(
      { this.name, required this.uri, this.data, this.state});

  factory MainRoute.home() => MainRoute(name: 'recommend', uri: Uri.parse('/'));

  factory MainRoute.unknown() =>
      MainRoute(name: 'unknown', uri: Uri.parse('/unknown'));

  factory MainRoute.project() =>
      MainRoute(name: 'project', uri: Uri.parse('/project'));

  factory MainRoute.parse(Uri uri) {
    if (uri.pathSegments.isEmpty) {
      return MainRoute.home();
    }

    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == 'project') {
        return MainRoute.project();
      }
    }

    return MainRoute.unknown();
  }

  @override
  bool operator ==(Object other) => other is MainRoute && other.uri == uri;

  @override
  int get hashCode => uri.hashCode;
}

class MainPageBuilder {
  final BuildContext context;
  final MainRoute homeRoutePath;

  MainPageBuilder(this.context, this.homeRoutePath);

  dynamic get page {
    switch (homeRoutePath.name) {
      case 'recommend':
        return MaterialPage(
          key: ValueKey('recommend'),
          name: homeRoutePath.name,
          child: HomePage(),
        );
      case 'project':
        return MaterialPage(
          key: ValueKey('projects'),
          name: homeRoutePath.name,
          child: ProjectsPage(),
        );
      default:
        return MaterialPage(
          key: ValueKey('unknown'),
          name: homeRoutePath.name,
          child: Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
              alignment: Alignment.center,
              child:
              Text('Unknown Page', style: TextStyle(color: Colors.white)),
            ),
          ),
        );
    }
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 0;
  @override
  void initState() {
    super.initState();
    print('Init Home Page');
  }

  @override
  Widget build(BuildContext context) {
    print("object");
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.amber,
        alignment: Alignment.center,
        child: Column(
          children: [
            Text('Home Page${Random().nextInt(100)}', style: TextStyle(color: Colors.white)),
            Text('Counter: $counter', style: TextStyle(color: Colors.white)),
            ElevatedButton(
                onPressed: () {
                  counter += 1;
                  setState(() {});
                },
                child: Text('Increment Counter')),
            ElevatedButton(
                onPressed: () {
                  (Router.of(context).routerDelegate as MainRouterDelegate)
                      .push(MainRoute.project());
                },
                child: Text('Open Projects')),
          ],
        ),
      ),
    );
  }
}

class ProjectsPage extends StatefulWidget {
  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    print('Init Projects Page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.pinkAccent,
        alignment: Alignment.center,
        child: Column(
          children: [
            Text('Projects Page', style: TextStyle(color: Colors.white)),
            Text('Counter: $counter', style: TextStyle(color: Colors.white)),
            ElevatedButton(
                onPressed: () {
                  counter += 1;
                  setState(() {});
                },
                child: Text('Increment Counter')),
            Padding(padding: EdgeInsets.only(bottom: 8)),
            ElevatedButton(
                onPressed: () =>
                    (Router.of(context).routerDelegate as MainRouterDelegate)
                        .pop(),
                child: Text('Back')),
            Padding(padding: EdgeInsets.only(bottom: 8)),
            ElevatedButton(
                onPressed: () =>
                    (Router.of(context).routerDelegate as MainRouterDelegate)
                        .push(MainRoute.home()),
                child: Text('Open Home')),
          ],
        ),
      ),
    );
  }
}