import 'package:flutter/material.dart';
import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebHome extends StatelessWidget {
  const WebHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Article article = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.title!,
          style: AppTextStyles.white_14.bold,
          maxLines: 2,
        ),
        titleSpacing: 0,
        actions: [
          IconButton(
            onPressed: () {
              //todo 点击收藏

            },
            icon: Icon(Icons.star_border),
          ),
        ],
      ),
      body: Container(
        child: WebView(
          initialUrl: article.link!,
        ),
      ),
    );
  }
}
