import 'package:flutter/material.dart';
import 'package:flutter_wan/home/widgets/home_item_view.dart';
import 'package:flutter_wan/method_channels.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:get/get.dart';

import '../status.dart';
import 'controller.dart';
import 'widgets/home_item_banner_view.dart';
import 'widgets/home_search_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
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
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              flex: 1,
              child: SearchView(),
            ),
            SizedBox(width: 16),
            TextButton(
              onPressed: () {
                MethodChannels.routeNative("/second");
              },
              child: Text(
                'TODO',
                style: AppTextStyles.white_16_bold,
              ),
            ),
          ],
        ),
      ),
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
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }
}
