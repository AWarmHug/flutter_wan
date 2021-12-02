import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/search.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';

class SearchContentItem extends StatelessWidget {
  final Article article;

  const SearchContentItem(this.article, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(
          100,
          Random().nextInt(255),
          Random().nextInt(255),
          Random().nextInt(255),
        ),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      padding: EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Html(
            data: "<body>${article.title!}</body>",
            style: {
              "body": Style(
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.all(0),
                  color: AppColors.black,
                  fontSize: FontSize(16),
                  fontWeight: FontWeight.bold),
            },
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.superChapterName!,
                    style: AppTextStyles.black_14.size(12),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    article.showAuthor,
                    style: AppTextStyles.black_14.size(12).bold,
                  ),
                ],
              ),
              Spacer(),
              SizedBox(
                height: 24,
                width: 24,
                child: IconButton(
                    onPressed: () {},
                    padding: EdgeInsets.all(0),
                    iconSize: 20,
                    icon: Icon(article.collect ? Icons.star : Icons.star_border)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
