import 'package:flutter/material.dart';
import 'package:flutter_wan/data/zhihu/question.dart';
import 'package:flutter_wan/data/zhihu/target.dart';

import 'zhihu/answer/answer_detail/answer_detail_view.dart';
import 'zhihu/answer/answer_list/answer_list_view.dart';
import 'zhihu/view.dart';

class TouchFishPage extends Page {
  TouchFishPage({required String name, Object? arguments})
      : super(key: ValueKey("${name}"), name: name, arguments: arguments);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        builder: (BuildContext context) {
          switch (name) {
            case "/touch_fish/zhihu":
              return ZhihuPage();
            case "/touch_fish/zhihu/answer_detail":
              return AnswerDetailScreen(arguments as Target);
            case "/touch_fish/zhihu/answer_list":
              return AnswerListPage(arguments as Question);
          }
          return ZhihuPage();
        },
        settings: this);
  }
}
