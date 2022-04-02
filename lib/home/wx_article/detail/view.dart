import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:flutter_wan/home/recommend/widgets/home_item_view.dart';
import 'package:flutter_wan/status.dart';
import 'package:flutter_wan/widget/smart_refresher.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'state.dart';

class WxArticleDetailScreen extends StatefulWidget {
  const WxArticleDetailScreen({Key? key, required this.tree}) : super(key: key);

  final Tree tree;

  @override
  _WxArticleDetailScreenState createState() {
    return _WxArticleDetailScreenState();
  }
}

class _WxArticleDetailScreenState extends State<WxArticleDetailScreen> {
  late WxArticleDetailPageController _controller;
  late WxArticleDetailPageState state;

  @override
  void initState() {
    super.initState();
    _controller = WxArticleDetailPageController(widget.tree);
    state = _controller.state;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WxArticleDetailPageController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: _showSearchView(controller),
            titleSpacing: 0,
          ),
          body: Container(
            child: SmartRefresher(
              onRefresh: _controller.refreshList,
              onLoad: _controller.loadMore,
              refreshController: _controller.refreshController,
              itemBuilder: (context, index) {
                return ItemView(state.articles[index]);
              },
              itemCount: state.articles.length,
              footer: (Status status) {
                return StatusMoreWidget(status: status);
              },
            ),
          ),
        );
      },
      init: _controller,
    );
  }

  Widget _showSearchView(WxArticleDetailPageController controller) {
    if (state.showSearchView) {
      return _SearchView(
        valueChanged: (value) {
          controller.setSearchKeyword(value);
          controller.loadWXArticleList();
        },
      );
    } else {
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(widget.tree.name!),
          ),
          TextButton(
            onPressed: () {
              controller.setShowSearchView(true);
            },
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      );
    }
  }
}

class _SearchView extends StatelessWidget {
  final ValueChanged<String> valueChanged;

  const _SearchView({Key? key, required this.valueChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 32,
            child: TextField(
              cursorColor: Colors.white,
              controller: _controller,
              textInputAction: TextInputAction.search,
              style: TextStyle(color: Colors.white),
              autofocus: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 16),
                hintStyle: TextStyle(color: Colors.white60),
                hintText: "想搜什么就搜什么~~~",
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                suffixIcon: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  borderSide: BorderSide(
                      color: Colors.white, width: 1, style: BorderStyle.solid),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.6),
                      width: 1,
                      style: BorderStyle.solid),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  borderSide: BorderSide(
                      color: Colors.white, width: 1, style: BorderStyle.solid),
                ),
              ),
              onEditingComplete: () => valueChanged(_controller.text),
            ),
          ),
        ),
        TextButton(
          onPressed: () => valueChanged(_controller.text),
          child: Text(
            "确定",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
