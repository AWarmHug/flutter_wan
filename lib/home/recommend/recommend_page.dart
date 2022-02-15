import 'package:flutter/material.dart';
import 'package:flutter_wan/method_channels.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:get/get.dart';

import '../../route.dart';
import '../../status.dart';
import 'controller.dart';
import 'widgets/home_item_banner_view.dart';
import 'widgets/home_item_view.dart';
import 'widgets/home_search_view.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({Key? key}) : super(key: key);

  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  HomePageController _controller = Get.put(HomePageController());
  final state = Get.find<HomePageController>().state;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //已经滑到底了
        _controller.loadArticleListNext();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RefreshIndicator(
          displacement: 60,
          onRefresh: _controller.refreshArticleList,
          child: GetBuilder<HomePageController>(
            init: _controller,
            builder: (logic) {
              return StatusWidget(
                status: state.refresh,
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return StatusWidget(
                        status: state.banners.status,
                        child: SizedBox(
                          height: 180,
                          child: PageView.builder(
                            itemBuilder: (context, index) {
                              return BannerItemView(state.banners.data![index]);
                            },
                            itemCount: state.banners.data!.length,
                          ),
                        ),
                      );
                    } else if (index > 0 && index < state.articles.length + 1) {
                      return ItemView(state.articles[(index) - 1]);
                    } else {
                      return StatusMoreWidget(
                        status: state.loadingMore.value,
                      );
                    }
                  },
                  itemCount: state.articles.length + 2,
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MyRouter.toNamed(context, "/search");
        },
        child: Icon(Icons.search),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }
}
