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
        theme: logic.themeData,
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
  ThemeData themeData = ThemeData(
      // primaryColor: AppColors.primary,
      brightness: Brightness.light,
      fontFamily: kIsWeb ? null : (Platform.isAndroid ? "font_default" : null));

  bool isLight = true;

  void changeMode(bool light) {
    isLight = light;
    themeData = themeData.copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: isLight ? themeData.primaryColor : Colors.black,
        ),
        bottomNavigationBarTheme: themeData.bottomNavigationBarTheme.copyWith(
          backgroundColor: isLight ? Colors.white : Colors.black,
        ));
    Get.changeTheme(themeData);

    // update();
  }
}
