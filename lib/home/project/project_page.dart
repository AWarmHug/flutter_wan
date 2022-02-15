import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'page_item/view.dart';

class ProjectPage extends StatefulWidget {
  ProjectPage({Key? key}) : super(key: key);

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with TickerProviderStateMixin {
  final controller = Get.put(ProjectPageController());

  final state = Get.find<ProjectPageController>().state;

  @override
  Widget build(BuildContext context) {
    return GetX<ProjectPageController>(
      init: controller,
      builder: (projectPageController) {
        final tabController =
            TabController(length: state.trees.length, vsync: this);
        return Container(
          child: Column(
            children: [
              TabBar(
                labelColor: Colors.black,
                labelPadding: EdgeInsets.symmetric(vertical: 6,horizontal: 4),
                unselectedLabelColor: Colors.black26,
                onTap: (value) {},
                indicator: BoxDecoration(),
                controller: tabController,
                isScrollable: true,
                tabs: state.trees.map((e) {
                  return Center(child: Text(e.name!));
                }).toList(),
              ),
              Expanded(
                child: TabBarView(
                  children: state.trees.map((e) {
                    return PageItemPage(e);
                  }).toList(),
                  controller: tabController,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
