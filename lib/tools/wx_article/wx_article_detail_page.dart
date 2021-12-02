import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:flutter_wan/home/widgets/home_item_view.dart';
import 'package:flutter_wan/status.dart';
import 'package:get/get.dart';

import 'wx_article_detail_page_controller.dart';

class WxArticleDetailPage extends StatefulWidget {
  const WxArticleDetailPage({Key? key}) : super(key: key);

  @override
  _WxArticleDetailPageState createState() {
    return _WxArticleDetailPageState();
  }
}

class _WxArticleDetailPageState extends State<WxArticleDetailPage> {
  WxArticleDetailPageController _controller = WxArticleDetailPageController();

  Tree tree = Get.arguments;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<WxArticleDetailPageController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: _showSearchView(controller),
            titleSpacing: 0,
          ),
          body: Container(
            child: StatusResourceWidget(
              builder: (BuildContext context) {
                return ListView.builder(
                  controller: _controller.scrollController,
                  itemBuilder: (context, index) {
                    if (index < controller.listData.value.data!.datas.length) {
                      return ItemView(
                          controller.listData.value.data!.datas[index]);
                    } else {
                      return StatusMoreWidget(
                          status: controller.listData.value.status);
                    }
                  },
                  itemCount: controller.listData.value.data!.datas.length + 1,
                );
              },
              resource: controller.listData.value,
            ),
          ),
        );
      },
      init: _controller,
    );
  }

  Widget _showSearchView(WxArticleDetailPageController controller) {
    if (controller.showSearchView.value) {
      return _SearchView(
        valueChanged: (value) {
          controller.loadWXArticleList(keyword: value);
        },
      );
    } else {
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(tree.name!),
          ),
          TextButton(
            onPressed: () {
              controller.showSearchView.value = true;
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
