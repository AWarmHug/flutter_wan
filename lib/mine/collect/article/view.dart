import 'package:flutter/material.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:flutter_wan/widget/smart_refresh.dart';
import 'package:get/get.dart';

import '../../../status.dart';
import 'logic.dart';

class ArticlePage extends StatelessWidget {
  final logic = Get.put(ArticleLogic());
  final state = Get.find<ArticleLogic>().state;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 44.0,
      onRefresh: () async {
        logic.refreshList();
      },
      child: GetBuilder<ArticleLogic>(
        init: logic,
        builder: (logic) {
          return SmartRefresh(
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  state.list[index].title!,
                  style: AppTextStyles.black_18_bold,
                ),
              );
            },
            itemCount: state.list.length,
            refreshController: logic.refreshController,
            onRefresh: logic.refreshList,
            onLoad: logic.loadNextPage,
            footer: (Status status) {
              return StatusMoreWidget(status: status);
            },
          );
        },
      ),
    );
  }
}
