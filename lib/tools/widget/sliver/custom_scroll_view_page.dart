import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomScrollViewPage extends StatelessWidget {
  const CustomScrollViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listView = SliverFixedExtentList(
      itemExtent: 56, //列表项高度固定
      delegate: SliverChildBuilderDelegate(
        (_, index) => ListTile(title: Text('$index')),
        childCount: 10,
      ),
    );
    var listView2 = SliverFixedExtentList(
      itemExtent: 56, //列表项高度固定
      delegate: SliverChildBuilderDelegate(
        (_, index) => ListTile(title: Text('AA$index')),
        childCount: 10,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("CustomScrollView"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderDelegate.builder(
              maxHeight: 80,
              minHeight: 50,
              builder: (context, shrinkOffset, overlapsContent) {
                return Container(
                  color: Colors.blue,
                  child: Text(
                      "shrinkOffset=$shrinkOffset,overlapsContent=$overlapsContent"),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: PageView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    child: Text("1"),
                    color: Colors.amber,
                  ),
                  Container(
                    child: Text("2"),
                    color: Colors.blue,
                  )
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderDelegate(
              //有最大和最小高度
              maxHeight: 80,
              minHeight: 50,
              child: buildHeader(1),
            ),
          ),
          listView,
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderDelegate.fixedHeight(
              //固定高度
              height: 50,
              child: buildHeader(2),
            ),
          ),
          listView2,
        ],
      ),
    );
  }

  // 构建 header
  Widget buildHeader(int i) {
    return Container(
      color: Colors.lightBlue.shade200,
      alignment: Alignment.centerLeft,
      child: Text("PersistentHeader $i"),
    );
  }
}

typedef SliverHeaderBuilder = Widget Function(
    BuildContext context, double shrinkOffset, bool overlapsContent);

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  // child 为 header
  SliverHeaderDelegate({
    required this.maxHeight,
    this.minHeight = 0,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        assert(minHeight <= maxHeight && minHeight >= 0);

  //最大和最小高度相同
  SliverHeaderDelegate.fixedHeight({
    required double height,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        maxHeight = height,
        minHeight = height;

  //需要自定义builder时使用
  SliverHeaderDelegate.builder({
    required this.maxHeight,
    this.minHeight = 0,
    required this.builder,
  });

  final double maxHeight;
  final double minHeight;
  final SliverHeaderBuilder builder;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    Widget child = builder(context, shrinkOffset, overlapsContent);
    //测试代码：如果在调试模式，且子组件设置了key，则打印日志
    assert(() {
      if (child.key != null) {
        print('${child.key}: shrink: $shrinkOffset，overlaps:$overlapsContent');
      }
      return true;
    }());
    // 让 header 尽可能充满限制的空间；宽度为 Viewport 宽度，
    // 高度随着用户滑动在[minHeight,maxHeight]之间变化。
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverHeaderDelegate old) {
    return old.maxExtent != maxExtent || old.minExtent != minExtent;
  }
}
