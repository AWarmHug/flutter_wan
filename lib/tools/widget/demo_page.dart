import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/tools/widget/provider/shopping/provider_shopping_cart.dart';

import 'inherited_widget/inherited_widget_page.dart';
import 'page_view/page_view_page.dart';
import 'provider/provider_page.dart';
import 'provider/shopping/login.dart';
import 'scrollable/scrollable_page.dart';

class WidgetPage extends StatefulWidget {
  const WidgetPage({Key? key}) : super(key: key);

  @override
  _WidgetPageState createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Widget"),
      ),
      body: ListView(
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => InheritedWidgetPage(),
                ),
              );
            },
            child: Text("InheritedWidgetPage"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ProviderPage(),
                ),
              );
            },
            child: Text("ProviderPage"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ShoppingCartApp(),
                ),
              );
            },
            child: Text("ShoppingCartApp"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => MyPageView(),
                ),
              );
            },
            child: Text("PageView"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ScrollablePage(),
                ),
              );
            },
            child: Text("ScrollablePage"),
          ),
        ],
      ),
    );
  }
}
