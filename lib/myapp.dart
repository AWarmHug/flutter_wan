import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'route.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = Get.put(AppLogic());

  var _methodChannel = MethodChannel('com.bingo/method_channel');

  var initRoute = "";

  @override
  void initState() {
    _methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "setInitRoute":
          _handleInitRoute(call);
          break;
      }
    });

    super.initState();
  }

  void _handleInitRoute(MethodCall call) {
    // setState(() {
    initRoute = call.arguments as String;
    MyRouter.toNamed(context,initRoute);
    debugPrint("TAG----${initRoute}");

    // });
  }

  final MyRouterDelegate _routerDelegate = MyRouterDelegate();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppLogic>(builder: (logic) {
      return MaterialApp.router(
        title: '玩安卓',
        scrollBehavior: CupertinoScrollBehavior(),
        theme: logic.lightTheme(),
        routerDelegate: _routerDelegate,
        routeInformationParser: MyRouteInformationParser(),
        // initialRoute: initRoute,
      );
    });
  }
}

class AppLogic extends GetxController {
  ThemeData _themeData = ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      toolbarHeight: 48,
    ),
    primaryColor: Colors.blue,
    fontFamily: kIsWeb ? null : (Platform.isAndroid ? "font_default" : null),
  );

  ThemeData lightTheme() {
    return _themeData.copyWith(
      brightness: Brightness.light,
      appBarTheme: _themeData.appBarTheme.copyWith(
        backgroundColor: _themeData.primaryColor,
      ),
      bottomNavigationBarTheme: _themeData.bottomNavigationBarTheme.copyWith(
        unselectedItemColor: Colors.black54,
        backgroundColor: Colors.white,
      ),
    );
  }

  ThemeData darkTheme() {
    return _themeData.copyWith(
      brightness: Brightness.dark,
      appBarTheme: _themeData.appBarTheme.copyWith(
        backgroundColor: Colors.black,
      ),
      bottomNavigationBarTheme: _themeData.bottomNavigationBarTheme.copyWith(
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
      ),
    );
  }

  bool isLight = true;

  void changeTheme(bool light) {
    if (isLight != light) {
      isLight = light;
      _themeData = isLight ? lightTheme() : darkTheme();
      Get.changeTheme(_themeData);
    }
  }
}
