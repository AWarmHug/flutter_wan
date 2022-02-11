import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/route.dart';

import 'global_key_page.dart';
import 'simple_demo_page.dart';

//Flutter | 深入浅出Key https://www.jianshu.com/p/510c72cecf26
//Flutter Key https://www.jianshu.com/p/cae82bb42a1e
//理解 Flutter 中的 Key https://www.jianshu.com/p/6e704112dc67

class KeyPage extends StatefulWidget {
  const KeyPage({Key? key}) : super(key: key);

  @override
  _KeyPageState createState() => _KeyPageState();
}

class _KeyPageState extends State<KeyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Key"),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          TextButton(
            onPressed: () {
              MyRouter.to(
                context,
                SimpleDemoPage(),
              );
            },
            child: Text("SimpleDemoPage"),
          ),
          TextButton(
            onPressed: () {
              MyRouter.to(
                context,
                GlobalKeyPage(),
              );
            },
            child: Text("GlobalKeyPage"),
          ),
        ],
      ),
    );
  }
}
