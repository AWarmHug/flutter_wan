import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../status.dart';
import 'navigation_page_controller.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("导航"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: GetX<NavigationController>(
            builder: (controller) {
              switch (controller.navigations.value.status) {
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(child: Text("发生错误"));
                default:
                  return ExpansionPanelList(
                    dividerColor: Colors.red,
                    animationDuration: Duration(seconds: 1),
                    expansionCallback: (panelIndex, isExpanded) {},
                    children: controller.navigations.value.data!.map((e) {
                      return ExpansionPanel(
                        canTapOnHeader: true,
                        isExpanded: true,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(e.name!),
                          );
                        },
                        body: Container(
                            child: GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 4,
                              children: e.articles!.map((e) {
                                return Center(child: Text(e.title!));
                              }).toList(),
                            )),
                      );
                    }).toList(),
                  );
              }
            },
            init: NavigationController(),
          ),
        ),
      ),
    );
  }
}
