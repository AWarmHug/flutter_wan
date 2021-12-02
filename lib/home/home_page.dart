import 'package:flutter/material.dart';
import 'package:flutter_wan/home/widgets/home_item_view.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:get/get.dart';

import '../status.dart';
import 'home_page_controller.dart';
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

      print(
          "_scrollController.position.pixels = ${_scrollController.position.pixels}");
      print(
          "_scrollController.position.maxScrollExtent = ${_scrollController.position.maxScrollExtent}");

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
      child: GetX<HomePageController>(
        init: _controller,
        initState: (_) {},
        builder: (logic) {
          return StatusWidget(
            status: _controller.articles.value.status,
            isWork: _controller.articles.value.data == null,
            builder: (BuildContext context) {
              return Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        titleSpacing: 0,
                        expandedHeight: 220,
                        backgroundColor: Colors.transparent,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                            child: StatusWidget(
                              status: _controller.banners.value.status,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 48.0),
                                  child: PageView.builder(
                                    itemBuilder: (context, index) {
                                      return BannerItemView(
                                          _controller.banners.value.data![index]);
                                    },
                                    itemCount:
                                        _controller.banners.value.data!.length,
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
                            if (index <
                                _controller.articles.value.data!.length) {
                              return ItemView(_controller
                                  .articles.value.data![index as int]);
                            } else {
                              return StatusMoreWidget(
                                status: _controller.articles.value.status,
                              );
                            }
                          },

                          childCount:
                              _controller.articles.value.data!.length + 1,
                        ),
                      ),
                    ],
                    controller: _scrollController,
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      _stateSetter = setState;
                      return Container(
                        decoration: BoxDecoration(color: AppColors.primary),
                        height: 78,
                        padding: EdgeInsets.only(
                            left: 16, top: 32, right: 16, bottom: 8),
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
                ],
              );
            },
          );
        },
      ),
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
