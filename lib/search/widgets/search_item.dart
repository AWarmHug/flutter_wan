import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_wan/data/search.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';

import '../../route.dart';

class SearchItem extends StatelessWidget {
  final HotKey hotKey;

  const SearchItem(this.hotKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        MyRouter.toNamed(context, "/search/content", arguments: hotKey.name);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(
            100,
            Random().nextInt(255),
            Random().nextInt(255),
            Random().nextInt(255),
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.all(4),
        child: Text(
          hotKey.name!,
          style: AppTextStyles.black_14.bold,
        ),
      ),
    );
  }
}
