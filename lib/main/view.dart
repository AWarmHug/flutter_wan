import 'package:flutter/material.dart';
import 'package:flutter_wan/home/home_page.dart';
import 'package:flutter_wan/mine/mine_home.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:flutter_wan/tools/tools_home.dart';
import 'package:flutter_wan/tree/tree_page.dart';
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

  final pages = [HomePage(), TreePage(), ToolsHome(), MineHome()];

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
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "主页"),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "分类"),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "工具"),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "我的"),
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
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey.shade700,
      ),
    );
  }
}
