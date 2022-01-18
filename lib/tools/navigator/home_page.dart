import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_wan/tools/navigator/main.dart';
import 'package:flutter_wan/tools/navigator/unknown_page.dart';

import 'my_router.dart';

class HomePage extends Page {
  HomePage({required String name, Object? arguments})
      : super(key: ValueKey("${name}"), name: name, arguments: arguments);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) {
        final uri = Uri.parse(name ?? "/home");
        String path = uri.path;
        String? arg = null;
        if (uri.pathSegments.length == 1) {
          path = uri.path;
        } else if (uri.pathSegments.length == 3) {
          if (uri.pathSegments[0] == "home" &&
              uri.pathSegments[1] == "detail") {
            path = "/${uri.pathSegments[0]}/${uri.pathSegments[1]}";
            arg = uri.pathSegments[2];
          } else {
            path = uri.path;
          }
        }
        print("-------${path}");
        switch (path) {
          case "/home":
            return HomeScreen(
              title: '${name}',
            );
          case "/home/detail":
            return HomeDetailScreen(
              id: arg,
            );
          default:
            return UnknownScreen();
        }
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              MyRouter.of(context)
                  .push("/home/detail/${Random().nextInt(100)}");
            },
            child: Text("TO /home/detail")),
      ),
    );
  }
}

class HomeDetailScreen extends StatelessWidget {
  const HomeDetailScreen({Key? key, required this.id}) : super(key: key);

  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeDetailScreen}"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("HomeDetailScreen/${id}"),
            TextButton(
                onPressed: () {
                  MyRouter.of(context).push("/user/${Random().nextInt(100)}");
                },
                child: Text("To User")),
          ],
        ),
      ),
    );
  }
}
