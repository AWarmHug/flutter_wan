import 'package:flutter/material.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("TopWidget----build");
    return ShareDataWidget(
      child: Column(
        children: [
          TextWidget(),
          TextWidget(),
          Text(
            "我不会变",
            style: TextStyle(color: Colors.blue),
          ),
          TextWidget3(),
        ],
      ),
    );
  }
}

class ShareDataWidget extends StatefulWidget {
  const ShareDataWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _ShareDataWidgetState createState() => _ShareDataWidgetState();
}

class _ShareDataWidgetState extends State<ShareDataWidget> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    debugPrint("_ShareDataWidgetState----build");
    return Theme(
      data: isDark
          ? ThemeData.light()
          : ThemeData.dark(),
      child: Container(
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                debugPrint("LayoutBuilder----build");
                return Text("data");
              },
            ),
            widget.child,
            TextButton(
              onPressed: () {
                setState(() {
                  isDark = !isDark;
                });
              },
              child: Text("点我"),
            ),
          ],
        ),
      ),
    );
  }
}

class TextWidget3 extends StatelessWidget {
  const TextWidget3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("TextWidget3----build");
    return Text(
      "我也不会变",
    );
  }
}

class TextWidget2 extends StatelessWidget {
  const TextWidget2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("TextWidget2----build");
    return Text(
      "点击了",
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}

class TextWidget extends StatefulWidget {
  const TextWidget({Key? key}) : super(key: key);

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    debugPrint("TextWidget----build");
    return Text(
      "TextWidget",
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("TextWidget----didChangeDependencies");
  }
}

class Empty extends StatelessWidget {
  final Widget child;

  const Empty({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class AppTheme extends StatelessWidget {
  const AppTheme({Key? key, required this.theme, required this.child})
      : super(key: key);

  final Widget child;

  final AppThemeData theme;

  @override
  Widget build(BuildContext context) {
    return _InheritedWidget(
      theme: theme,
      child: Empty(
        child: child,
      ),
    );
  }

  static AppThemeData of(BuildContext context) {
    return _InheritedWidget.of(context)!.theme;
  }
}

class _InheritedWidget extends InheritedWidget {
  final Widget child;

  final AppThemeData theme;

  _InheritedWidget({required this.child, required this.theme})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant _InheritedWidget oldWidget) {
    debugPrint(
        "_InheritedWidget----updateShouldNotify---count=${theme}---oldWidget.count=${oldWidget.theme}");

    return theme != oldWidget.theme;
  }

  static _InheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_InheritedWidget>();
  }
}

class AppThemeData {
  Color backgroundColor;

  Color textColor;

  AppThemeData(this.backgroundColor, this.textColor);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '玩安卓',
        home: Scaffold(
          body: Center(child: TopWidget()),
        ));
  }
}
