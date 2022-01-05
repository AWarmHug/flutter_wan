import 'package:flutter/material.dart';

class InheritedWidgetPage extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InheritedWidget"),
      ),
      body: Container(
        child: ContentPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text("+1"),
      ),
    );
  }
}

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {

  int count = 0;


  @override
  Widget build(BuildContext context) {
    return _InheritedWidget(
      data: count,
      child: Column(
        children: [
          CounterWidget(),
          TextButton(
              onPressed: () {
                count++;
                setState(() {

                });
              },
              child: Text("添加"))
        ],
      ),
    );
  }
}


class CounterWidget extends StatefulWidget {
  const CounterWidget({Key? key}) : super(key: key);

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(_InheritedWidget.of(context)?.data.toString()??"");
  }
}

class _InheritedWidget<T> extends InheritedWidget {
  const _InheritedWidget({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  final T data;

  static _InheritedWidget? of(BuildContext context) {
    final _InheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_InheritedWidget>();
    // assert(result != null, 'No MyInheritedWidget found in context');
    return result;
  }

  @override
  bool updateShouldNotify(_InheritedWidget old) {
    return data != old.data;
  }
}
