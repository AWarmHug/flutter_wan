import 'package:flutter/material.dart';
import 'package:flutter_wan/todo/todo_screen.dart';


class TodoPage extends Page {
  TodoPage({required String name, Object? arguments})
      : super(key: ValueKey("${name}"), name: name, arguments: arguments);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        builder: (BuildContext context) {
          switch (name) {
            case "/todo/list":
              return TodoListScreen();
          }
          return TodoListScreen();
        },
        settings: this);
  }
}
