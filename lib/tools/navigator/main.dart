import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'my_router.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final delegate = MyRouterDelegate();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        theme: ThemeData.light(),
        routeInformationParser: MyRouteInformationParser(),
        routerDelegate: delegate
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("-----hsshdjkds----}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Main"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("${Random().nextInt(100)}"),
            TextButton(
                onPressed: () {
                  MyRouter.of(context).push("/");
                },
                child: Text("TO Main")),
            TextButton(
                onPressed: () {
                  MyRouter.of(context).push("/home");
                },
                child: Text("TO /home")),
          ],
        ),
      ),
    );
  }
}
