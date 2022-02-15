import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:flutter_wan/route.dart';
import 'package:flutter_wan/web/web_srceen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../http.dart';
import 'logic.dart';

class PageItemPage extends StatelessWidget {
  final Tree tree;

  PageItemPage(this.tree);

  PageController pageController = PageController(
    keepPage: false,
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(PageItemLogic(tree), tag: tree.id.toString());
    final state = Get.find<PageItemLogic>(tag: tree.id.toString()).state;

    return GetBuilder<PageItemLogic>(
        init: logic,
        tag: tree.id.toString(),
        builder: (projectPageController) {
          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return _ProjectItem(state.articles[index]);
            },
            itemCount: state.articles.length,
            controller: pageController,
            onPageChanged: (value) {
              if (value == state.articles.length - 1) {
                logic.loadMoreProjectList();
              }
            },
          );
        });
  }
}

class _ProjectItem extends StatelessWidget {
  const _ProjectItem(this._article, {Key? key}) : super(key: key);

  final Article _article;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        MyRouter.toNamed(context,"/web", arguments: WebInfo(_article.title, _article.link!));
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
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: _article.envelopePic!,
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width,
                      placeholder: (context, url) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                        decoration: BoxDecoration(color: Colors.black38),
                        child: Text(
                          (_article.desc ?? "").trim(),
                          style: AppTextStyles.white_14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Text(
                  _article.chapterName!,
                  style: AppTextStyles.light_14.size(12),
                ),
                Expanded(child: Text("")),
                SizedBox(
                  height: 24,
                  width: 48,
                  child: StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setState) {
                      return IconButton(
                          onPressed: () {
                            if (!_article.collect) {
                              Http.post<ResponseWan>(
                                      "/lg/collect/${_article.id}/json", {})
                                  .then((value) {
                                if (value.isSuccess) {
                                  setState(() {
                                    _article.collect = !_article.collect;
                                  });
                                  Fluttertoast.showToast(msg: "收藏成功");
                                } else {
                                  Fluttertoast.showToast(msg: "收藏失败");
                                }
                              });
                            } else {
                              Http.post<ResponseWan>(
                                  "/lg/uncollect_originId/${_article.id}/json",
                                  {}).then((value) {
                                if (value.isSuccess) {
                                  setState(() {
                                    _article.collect = !_article.collect;
                                  });
                                  Fluttertoast.showToast(msg: "取消收藏");
                                } else {
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
