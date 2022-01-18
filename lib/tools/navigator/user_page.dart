import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_wan/tools/navigator/unknown_page.dart';

import 'my_router.dart';

class UserPage extends RouterPage {
  UserPage(String name) : super(name: name);

  @override
  Widget createWidget(BuildContext context) {
    final uri = Uri.parse(name ?? "/user");
    String path = uri.path;
    String? arg = null;
    if (uri.pathSegments.length == 1) {
      path = uri.path;
    } else if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] == "user") {
        path = "/${uri.pathSegments[0]}";
        arg = uri.pathSegments[1];
      } else {
        path = uri.path;
      }
    }
    switch (path) {
      case "/user":
        return UserScreen(
          id: arg,
        );
      default:
        return UnknownScreen();
    }
  }
}

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key, required this.id}) : super(key: key);
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User"),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              MyRouter.of(context).push("/user/${Random().nextInt(100)}");
            },
            child: Text("User${id}")),
      ),
    );
  }
}
