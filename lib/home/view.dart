import 'package:flutter/material.dart';
import 'package:flutter_wan/home/widgets/home_item_view.dart';
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

  StateSetter? _stateSetter;
  double trans = 0.5;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //已经滑到底了
        _controller.loadArticleListNext();
      }

      if (_scrollController.offset < 220) {
        if (_stateSetter != null) {
          _stateSetter!(() {
            trans = 0.7 + (_scrollController.offset / 440.0);
            if (trans > 1) {
              trans = 1;
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        RefreshIndicator(
          edgeOffset: 54,
          displacement: 88,
          onRefresh: _controller.refreshArticleList,
          child: GetBuilder<HomePageController>(
            init: _controller,
            builder: (logic) {
              return StatusWidget(
                status: state.refresh,
                builder: (BuildContext context) {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        titleSpacing: 0,
                        expandedHeight: 220,
                        backgroundColor: Colors.transparent,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                            child: StatusWidget(
                              status: state.banners.value.status,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 48.0),
                                  child: PageView.builder(
                                    itemBuilder: (context, index) {
                                      return BannerItemView(
                                          state.banners.value.data![index]);
                                    },
                                    itemCount: state.banners.value.data!.length,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, num index) {
                            if (index < state.articles.length) {
                              return ItemView(state.articles[index as int]);
                            } else {
                              return StatusMoreWidget(
                                status: state.loadingMore.value,
                              );
                            }
                          },
                          childCount: state.articles.length + 1,
                        ),
                      ),
                    ],
                    controller: _scrollController,
                  );
                },
              );
            },
          ),
        ),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            _stateSetter = setState;
            return Container(
              decoration: BoxDecoration(color: AppColors.primary),
              height: 78,
              padding: EdgeInsets.only(left: 16, top: 32, right: 16, bottom: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SearchView(),
                    ),
                    SizedBox(width: 16),
                    Text(
                      'TODO',
                      style: AppTextStyles.white_16_bold,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
