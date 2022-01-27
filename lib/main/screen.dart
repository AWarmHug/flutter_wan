import 'package:flutter/material.dart';
import 'package:flutter_wan/eventbus.dart';
import 'package:flutter_wan/home/view.dart';
import 'package:flutter_wan/mine/mine_home.dart';
import 'package:flutter_wan/resource/IconFontIcons.dart';
import 'package:flutter_wan/resource/app_colors.dart';
import 'package:flutter_wan/tools/tools_page.dart';
import 'package:flutter_wan/touch_fish/zhihu/view.dart';
import 'package:get/get.dart';

import '../myapp.dart';
import 'logic.dart';
import 'state.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final pages = [HomePage(), ZhihuPage(), ToolsScreen(), MineHome()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return MainSmallPage(
            pages: pages,
          );
        } else {
          return MainLargePage(
            pages: pages,
          );
        }
      },
    );
  }
}

class MainSmallPage extends StatelessWidget {
  MainSmallPage({Key? key, required this.pages}) : super(key: key);
  final List<Widget> pages;

  final MainLogic logic = Get.put(MainLogic());

  final MainState state = Get.find<MainLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainLogic>(builder: (logic) {
      return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: IndexedStack(
          index: state.selectedIndex,
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
            logic.setSelectedIndex(value);
            if (value != 1) {
              Get.find<AppLogic>().changeTheme(true);
              bus.emit("video", false);
            }
          },
          currentIndex: state.selectedIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 4.0,
        ),
      );
    });
  }
}

class MainLargePage extends StatelessWidget {
  MainLargePage({Key? key, required this.pages}) : super(key: key);
  final List<Widget> pages;
  final MainLogic logic = Get.put(MainLogic());

  final MainState state = Get.find<MainLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: GetBuilder<MainLogic>(builder: (logic) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ItemsWidget(
                items: [
                  Item(icon: IconFontIcons.iconHome, title: "主页"),
                  Item(icon: IconFontIcons.iconTouchfish, title: "知乎"),
                  Item(icon: IconFontIcons.iconTools, title: "工具"),
                  Item(icon: IconFontIcons.iconMine, title: "我的"),
                ],
                onTap: (value) {
                  logic.setSelectedIndex(value);
                  if (value != 1) {
                    Get.find<AppLogic>().changeTheme(true);
                    bus.emit("video", false);
                  }
                },
                currentIndex: state.selectedIndex,
              ),
            ),
            Expanded(
              flex: 3,
              child: IndexedStack(
                index: state.selectedIndex,
                children: pages,
              ),
            ),
          ],
        );
      }),
    );
  }
}

class ItemsWidget extends StatefulWidget {
  const ItemsWidget(
      {Key? key,
      required this.items,
      required this.onTap,
      required this.currentIndex})
      : super(key: key);
  final List<Item> items;
  final ValueChanged<int> onTap;
  final int currentIndex;

  @override
  _ItemsWidgetState createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final BottomNavigationBarThemeData bottomTheme =
        BottomNavigationBarTheme.of(context);

    List<Widget> items = [];
    for (int i = 0; i < widget.items.length; i++) {
      Item item = widget.items[i];

      bool selected = i == widget.currentIndex;

      _ItemTile _itemTile = _ItemTile(
        item: TextButton(
          onPressed: () {
            widget.onTap.call(i);
          },
          child: SizedBox(
            height: 48,
            child: Row(
              children: [
                Icon(
                  item.icon,
                  color: selected
                      ? themeData.primaryColor
                      : bottomTheme.unselectedItemColor,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  item.title,
                  style: TextStyle(
                    color: selected
                        ? themeData.primaryColor
                        : bottomTheme.unselectedItemColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        selected: selected,
      );
      items.add(_itemTile);
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 150,
            color: AppColors.primary,
            child: Center(
              child: Text(
                'Wan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: items,
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({Key? key, required this.item, required this.selected})
      : super(key: key);
  final Widget item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return item;
  }
}

class Item {
  const Item({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;
}
