import 'package:flutter/material.dart';
import 'package:flutter_wan/data/article.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:flutter_wan/status.dart';
import 'package:get/get.dart';

import 'project_page_controller.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ProjectPageController>(
      init: ProjectPageController(),
      initState: (_) {},
      builder: (projectPageController) {
        switch (projectPageController.trees.value.status) {
          case Status.LOADING:
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          case Status.ERROR:
            return Scaffold(body: Center(child: Text("发生错误")));
          default:
            return DefaultTabController(
              length: projectPageController.trees.value.data!.length,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("项目"),
                  bottom: TabBar(
                    onTap: (value) {},
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: EdgeInsets.only(
                        left: 6.0, top: 0, right: 6, bottom: 12),
                    tabs: projectPageController.trees.value.data!.map((e) {
                      return Center(child: Text(e.name!));
                    }).toList(),
                  ),
                ),
                body: TabBarView(
                  children: projectPageController.trees.value.data!.map((e) {
                    return ProjectPageItem(e);
                  }).toList(),
                ),
              ),
            );
        }
      },
    );
  }
}

class ProjectPageItem extends StatefulWidget {
  ProjectPageItem(this.tree, {Key? key}) : super(key: key);
  final Tree tree;

  @override
  _ProjectPageItemState createState() => _ProjectPageItemState();
}

class _ProjectPageItemState extends State<ProjectPageItem> {
  ProjectPageController controller = Get.find<ProjectPageController>();
  final List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    controller.loadProjectList(widget.tree.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetX<ProjectPageController>(
          init: controller,
          initState: (state) {},
          builder: (projectPageController) {
            return StatusResourceWidget(
              resource: projectPageController.list.value,
              builder: (context) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Text(articles[index].title!);
                  },
                  itemCount: articles.length,
                );
              },
            );
          }),
    );
  }
}
