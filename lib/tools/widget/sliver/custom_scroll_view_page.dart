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

    return Scaffold(
      appBar: AppBar(
        title: Text("CustomScrollView"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: PageView(
                scrollDirection: Axis.vertical,
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
          listView,
          listView,
        ],
      ),
    );
  }
}
