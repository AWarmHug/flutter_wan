import 'package:flutter/material.dart';
import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:flutter_wan/home/widgets/home_item_view.dart';
import 'package:flutter_wan/status.dart';
import 'package:flutter_wan/widget/smart_refresh.dart';
import 'package:get/get.dart';

import '../controller.dart';
import 'controller.dart';

class PageItem extends StatelessWidget {
  final Tree tree;

  const PageItem({Key? key, required this.tree}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageItemController logic =
        Get.put(PageItemController(tree), tag: tree.name);
    final state = Get.find<PageItemController>(tag: tree.name).state;
    return GetBuilder<PageItemController>(
      init: logic,
      tag:  tree.name,
      builder: (logic) {
        return SmartRefresher(
          onRefresh: () => logic.refreshList(tree),
          onLoad: () => logic.loadMoreList(tree),
          refreshController: logic.refreshController,
          itemBuilder: (context, index) {
            return ItemView(state.articles[index]);
          },
          itemCount: state.articles.length,
          footer: (status) {
            return StatusMoreWidget(status: status);
          },
        );
      },
    );
  }
}
