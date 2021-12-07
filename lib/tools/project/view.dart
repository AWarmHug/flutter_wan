import 'package:flutter/material.dart';
import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:flutter_wan/status.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'page_item/view.dart';

class ProjectPage extends StatelessWidget {
  ProjectPage({Key? key}) : super(key: key);

  final controller = Get.put(ProjectPageController());
  final state = Get.find<ProjectPageController>().state;

  @override
  Widget build(BuildContext context) {
    return GetX<ProjectPageController>(
      init: controller,
      builder: (projectPageController) {
        return DefaultTabController(
          length: state.trees.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text("项目"),
              bottom: TabBar(
                onTap: (value) {},
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding:
                    EdgeInsets.only(left: 6.0, top: 0, right: 6, bottom: 12),
                tabs: state.trees.map((e) {
                  return Center(child: Text(e.name!));
                }).toList(),
              ),
            ),
            body: TabBarView(
              children: state.trees.map((e) {
                return PageItemPage(e);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}


