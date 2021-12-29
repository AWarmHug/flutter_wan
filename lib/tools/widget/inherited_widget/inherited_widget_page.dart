import 'package:flutter/material.dart';


class InheritedWidgetPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InheritedWidget"),
      ),
      body: Page(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DataWidget.of(context)!.notifier!.value += 1;
        },
        child: Text("+1"),
      ),
    );
  }
}

class Page extends StatefulWidget {
  const Page({Key? key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  late ValueNotifier<int> _valueNotifier;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier(0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          DataWidget2(
            value: _valueNotifier,
            child: _TestWidget(),
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  _valueNotifier.value += 1;
                });
              },
              child: Text("+1"))
        ],
      ),
    );
  }
}

class _TestWidget extends StatefulWidget {
  @override
  __TestWidgetState createState() => __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    //使用InheritedWidget中的共享数据
    return Text(DataWidget2.of(context)!.value.value.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("Dependencies change");
  }
}

class DataWidget extends InheritedNotifier<ValueNotifier<int>> {
  DataWidget(
      {Key? key, required ValueNotifier<int> notifier, required Widget child})
      : super(key: key, notifier: notifier, child: child);

  static DataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataWidget>();
  }
}

class DataWidget2 extends InheritedWidget {
  DataWidget2({Key? key, required this.value, required Widget child})
      : super(key: key, child: child);

  final ValueNotifier<int> value;

  static DataWidget2? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataWidget2>();
  }

  @override
  bool updateShouldNotify(covariant DataWidget2 oldWidget) {
    return value!=oldWidget.value;
  }
}
