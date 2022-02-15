import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wan/data/navigation.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:flutter_wan/route.dart';
import 'package:flutter_wan/web/web_srceen.dart';
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
    return Container(
      child: GetX<NavigationController>(
        builder: (controller) {
          switch (controller.navigations.value.status) {
            case Status.LOADING:
              return Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(child: Text("发生错误"));
            default:
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  Navigation navigation =
                      controller.navigations.value.data![index];
                  return ExpansionTile(
                    key: PageStorageKey<Navigation>(navigation),
                    tilePadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    childrenPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                    title: Text(
                      navigation.name!,
                      style: AppTextStyles.black54_16,
                    ),
                    children: navigation.articles!.map((e) {
                      return InkWell(
                        onTap: () {
                          MyRouter.toNamed(context, "/web",arguments: WebInfo(e.title, e.link!));
                        },
                        child: Container(
                            width: double.infinity,
                            padding:
                                EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                            margin: EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: Theme.of(context).primaryColor),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.title!,
                                  style: AppTextStyles.white_16_bold,
                                ),
                                Text(
                                  e.link!,
                                  style: AppTextStyles.white_14,
                                ),
                              ],
                            )),
                      );
                    }).toList(),
                  );
                },
                itemCount: controller.navigations.value.data!.length,
              );
          }
        },
        init: NavigationController(),
      ),
    );
  }
}
