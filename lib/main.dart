import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:get/get.dart';

import 'global.dart';
import 'main/view.dart';
import 'route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final controller = Get.put(AppLogic());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppLogic>(builder: (logic) {
      return GetMaterialApp(
        title: '玩安卓',
        scrollBehavior: CupertinoScrollBehavior(),
        theme: logic.lightTheme(),
        home: FutureBuilder(
          future: Global.init(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return MainPage();
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        getPages: pages,
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
    primaryColor: AppColors.primary,
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

  void changeMode(bool light) {
    isLight = light;
    _themeData = isLight ? lightTheme() : darkTheme();
    Get.changeTheme(_themeData);
  }
}
