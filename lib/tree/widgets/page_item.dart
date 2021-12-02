import 'package:flutter/material.dart';
import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/data_list.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:flutter_wan/home/widgets/home_item_view.dart';
import 'package:flutter_wan/status.dart';
import 'package:get/get.dart';

import '../tree_page_controller.dart';

class PageItem extends StatefulWidget {
  final Tree tree;

  const PageItem(this.tree, {Key? key}) : super(key: key);

  @override
  _PageItemState createState() => _PageItemState();
}

class _PageItemState extends State<PageItem> {
  final TreePageController logic = Get.put(TreePageController());
  ScrollController _scrollController = ScrollController();

  int pageNum = 0;

  Resource<List<Article>> articles = Resource.loading();

  @override
  void initState() {
    super.initState();
    _loadTreeList();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //已经滑到底了
        pageNum += 1;
        _loadTreeList();
      }
    });
  }

  @override
  void updateKeepAlive() {
    print("updateKeepAlive");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TreePageController>(
      builder: (logic) {
        return StatusResourceWidget(
          resource: articles,
          builder: (BuildContext context) {
            return ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {
                if (index < articles.data!.length) {
                  return ItemView(articles.data![index]);
                } else {
                  return StatusMoreWidget(status: articles.status);
                }
              },
              itemCount: articles.data!.length + 1,
            );
          },
        );
      },
    );
  }


  void _loadTreeList() {
    if (pageNum == 0) {
      articles = Resource.loading();
    } else {
      articles = Resource.loadingMore(articles.data);
    }
    logic.loadTreeList(pageNum, widget.tree).then((value) {
      ResponseWan<ListData<Article>> responseWan = value;
      if (responseWan.isSuccess) {
        setState(() {
          if (pageNum == 0) {
            articles = Resource.success(responseWan.data!.datas);
          } else {
            var a = articles.data;
            a!.addAll(responseWan.data!.datas);
            articles = Resource.success(a);
          }
        });
      }
    });
  }
}
