import 'package:flutter/material.dart';
import 'package:flutter_wan/todo/todo_screen.dart';

import 'content/search_content_home.dart';
import 'search_screen.dart';

class SearchPage extends Page {
  SearchPage({required String name, Object? arguments})
      : super(key: ValueKey("${name}"), name: name, arguments: arguments);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        builder: (BuildContext context) {
          switch (name) {
            case "/search/home":
              return SearchScreen();
            case "/search/content":
              return SearchContentHome(arguments as String);
          }
          return SearchScreen();
        },
        settings: this);
  }
}
