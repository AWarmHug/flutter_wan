import 'package:flutter/material.dart';

class GlobalKeyPage extends StatefulWidget {
  const GlobalKeyPage({Key? key}) : super(key: key);

  @override
  State<GlobalKeyPage> createState() => _GlobalKeyPageState();
}

class _GlobalKeyPageState extends State<GlobalKeyPage> {
  GlobalKey<_SwitcherWidgetState> key=GlobalKey<_SwitcherWidgetState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GlobalKeyDemo"),
      ),
      body: Container(
        child: SwitcherWidget(key: key,),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("点击"),
        onPressed: () {
          key.currentState!.changeState();
        },
      ),
    );
  }
}

class SwitcherWidget extends StatefulWidget {
  const SwitcherWidget({Key? key}) : super(key: key);

  @override
  _SwitcherWidgetState createState() => _SwitcherWidgetState();
}

class _SwitcherWidgetState extends State<SwitcherWidget> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Switch.adaptive(
          value: isActive,
          onChanged: (value) {
            setState(() {
              isActive = value;
            });
          },
        ),
      ),
    );
  }

  void changeState() {
    isActive = !isActive;
    setState(() {});
  }
}
