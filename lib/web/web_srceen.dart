import 'package:flutter/material.dart';
import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatelessWidget {
  const WebScreen({Key? key, required this.webInfo}) : super(key: key);

  final WebInfo webInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          webInfo.title??"",
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
          initialUrl:webInfo.link,
        ),
      ),
    );
  }
}

class WebInfo{
  final String? title;
  final String link;

  WebInfo(this.title, this.link);
}
