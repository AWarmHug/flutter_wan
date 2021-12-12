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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '玩安卓',
      scrollBehavior: CupertinoScrollBehavior(),
      theme: ThemeData(
          // primaryColor: AppColors.primary,
          brightness: Brightness.light,
          fontFamily:
              kIsWeb ? null : (Platform.isAndroid ? "font_default" : null)),
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
  }
}
