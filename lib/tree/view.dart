import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:flutter_wan/tree/widgets/VTab.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'widgets/page_item.dart';

class TreePage extends StatefulWidget {
  @override
  _TreePageState createState() => _TreePageState();
}

class _TreePageState extends State<TreePage> with TickerProviderStateMixin {
  final TreePageController logic = Get.put(TreePageController());
  final _state = Get.find<TreePageController>().state;

  @override
  void initState() {
    super.initState();

    logic.loadTree();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          child: Obx(() {
            if (_state.trees.value != null) {
              return Builder(
                builder: (context) {
                  return VTabs(
                    _state.trees.value!.data!,
                    valueChanged: (int value) {
                      logic.setSelectedTree(_state.trees.value!.data![value]);
                    },
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
        ),
      ),
      body: Container(
        child: Obx(() {
          if (_state.selectedTree.value != null) {
            TabController _controller = TabController(
              initialIndex: 0,
              length: _state.selectedTree.value!.children!.length,
              vsync: this,
            );
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    height: 28,
                    child: TabBar(
                      controller: _controller,
                      labelColor: Colors.white,
                      unselectedLabelColor: Theme.of(context).primaryColor,
                      unselectedLabelStyle: AppTextStyles.light_14,
                      indicatorWeight: 1,
                      isScrollable: true,
                      labelStyle: AppTextStyles.light_14.bold,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Theme.of(context).accentColor,
                      ),
                      labelPadding: EdgeInsets.only(left: 8, right: 8),
                      tabs: _state.selectedTree.value!.children!.map((e) {
                        return Tab(
                          text: e.name,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _controller,
                    children: _state.selectedTree.value!.children!.map((e) {
                      return Container(
                        child: Center(
                          child: PageItem(
                            e,
                            key: GlobalKey(),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
