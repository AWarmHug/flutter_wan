import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchPage extends StatelessWidget {
  const SwitchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider(
        create: (context) {
          return Open();
        },
        child: Row(
          children: [
            Selector<Open, bool>(
              builder: (context, value, child) {
                return Text("${value}");
              },
              selector: (context, open) {
                return open._isOpen;
              },
            ),
            MySwitch(),
          ],
        ),
      ),
    );
  }
}

class Open with ChangeNotifier {
  bool _isOpen = false;

  void changeOpen(bool open) {
    Future.delayed(Duration(seconds: 3), () {
      _isOpen = open;
      notifyListeners();
    });
  }
}

class MySwitch extends StatelessWidget {
  const MySwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () {
          Open open = context.read();
          open.changeOpen(!open._isOpen);
        },
        child: Text("点我"),
      ),
    );
  }
}
