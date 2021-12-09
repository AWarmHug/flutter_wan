import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../http.dart';

class ItemView extends StatelessWidget {
  final Article _article;

  const ItemView(
    this._article, {
    Key? key,
  }) : super(key: key);

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(kIsWeb){
          _launchURL(_article.link!);
        }else {
          Get.toNamed("/web", arguments: _article);
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.only(left: 14, top: 12, right: 14, bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _article.title ?? "",
              style: AppTextStyles.black_16.bold,
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Text(
                  _article.showChapterName,
                  style: AppTextStyles.light_14.size(12),
                ),
                Expanded(child: Text("")),
                SizedBox(
                  height: 24,
                  width: 48,
                  child: StatefulBuilder(
                    builder: (BuildContext context, void Function(void Function()) setState) {
                      return  IconButton(
                          onPressed: () {
                            if(!_article.collect) {
                              Http.post<ResponseWan>(
                                  "/lg/collect/${_article.id}/json", {})
                                  .then((value) {
                                    if(value.isSuccess){
                                      setState((){
                                        _article.collect=!_article.collect;
                                      });
                                      Fluttertoast.showToast(msg: "收藏成功");
                                    }else{
                                      Fluttertoast.showToast(msg: "收藏失败");
                                    }
                              });
                            }else{
                              Http.post<ResponseWan>(
                                  "/lg/uncollect_originId/${_article.id}/json", {})
                                  .then((value) {
                                if(value.isSuccess){
                                  setState((){
                                    _article.collect=!_article.collect;
                                  });
                                  Fluttertoast.showToast(msg: "取消收藏");
                                }else{
                                  Fluttertoast.showToast(msg: "取消收藏失败");
                                }
                              });
                            }
                          },
                          padding: EdgeInsets.all(0),
                          iconSize: 20,
                          icon: Icon(
                            _article.collect ? Icons.star : Icons.star_border,
                            color: _article.collect
                                ? Colors.yellow
                                : AppColors.light,
                          ));
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  _article.showAuthor,
                  style: AppTextStyles.text_14.bold.size(12),
                ),
                Expanded(child: Text("")),
                Text(
                  _article.showPublishTime,
                  style: AppTextStyles.light_14,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
