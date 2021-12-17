import 'package:flutter/material.dart';
import 'package:flutter_wan/home/view.dart';
import 'package:flutter_wan/mine/mine_home.dart';
import 'package:flutter_wan/resource/IconFontIcons.dart';
import 'package:flutter_wan/tools/tools_home.dart';
import 'package:flutter_wan/touch_fish/zhihu/view.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainLogic logic = Get.put(MainLogic());

  final MainState state = Get.find<MainLogic>().state;

  final pages = [HomePage(), ZhihuPage(), ToolsHome(), MineHome()];

  var _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(IconFontIcons.iconHome), label: "主页"),
          BottomNavigationBarItem(
              icon: Icon(IconFontIcons.iconTouchfish), label: "知乎"),
          BottomNavigationBarItem(
              icon: Icon(IconFontIcons.iconTools), label: "工具"),
          BottomNavigationBarItem(
              icon: Icon(IconFontIcons.iconMine), label: "我的"),
        ],
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 4.0,
      ),
    );
  }
}
