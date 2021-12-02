import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/global.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:flutter_wan/resource/app_test_styles.dart';
import 'package:flutter_wan/status.dart';
import 'package:get/get.dart';

import 'mine_controller.dart';

class MineHome extends StatelessWidget {
  const MineHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<MineController>(
        init: MineController(),
        initState: (_) {},
        builder: (mineController) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                snap: false,
                expandedHeight: 200,
                backgroundColor: Theme.of(context).primaryColor,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(),
                    child: InkWell(
                      onTap: !Global.isLogin.value
                          ? () {
                              Get.toNamed("login/login");
                            }
                          : null,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipOval(
                            child: Image.network(
                              "https://img1.baidu.com/it/u=569706492,774905032&fm=26&fmt=auto&gp=0.jpg",
                              width: 80,
                              height: 80,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Builder(
                            builder: (context) {
                              if (mineController.userResource.value.status ==
                                  Status.SUCCESS) {
                                return Text(
                                    mineController.userResource.value.data!
                                        .userInfo!.publicName!,
                                    style: AppTextStyles.black_18_bold.copyWith(
                                      color: AppColors.white,
                                    ));
                              } else {
                                return Text("未登录",
                                    style: AppTextStyles.black_18_bold.copyWith(
                                      color: AppColors.white,
                                    ));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    InkWell(
                      onTap: () {
                        Get.toNamed("/mine/collect");
                      },
                      child: Container(
                        child: Text(
                          "我的收藏",
                          style: AppTextStyles.black_16,
                        ),
                        padding: EdgeInsets.only(
                            left: 16, top: 12, right: 16, bottom: 12),
                      ),
                    ),
                    Visibility(
                      visible: Global.isLogin.value,
                      child: InkWell(
                        onTap: () {
                          mineController.logout();
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 16, top: 12, right: 16, bottom: 12),
                          child: Text("退出登录", style: AppTextStyles.black_16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
