import 'dart:math';

import 'package:flutter/material.dart';

class SimpleDemoPage extends StatelessWidget {
  const SimpleDemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("简单的例子"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SwitchWidget(),
            SwitchWidget2(),
            SwitchWidget3(),
            SwitchWidget4(),
            SwitchWidget5(),
          ],
        ),
      ),
    );
  }
}




class RandomColor {
  Color randomColor() {
    return Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255),
        Random().nextInt(255));
  }
}

class StatelessContainer extends StatelessWidget {
  final Color color = RandomColor().randomColor();

  StatelessContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: 120,
      height: 120,
    );
  }
}

class StatefulContainer extends StatefulWidget {
  StatefulContainer({Key? key}) : super(key: key);

  @override
  State<StatefulContainer> createState() {
    return _StatefulContainerState();
  }
}

class _StatefulContainerState extends State<StatefulContainer> {

  final Color color = RandomColor().randomColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: 120,
      height: 120,
    );
  }
}

class SwitchWidget extends StatefulWidget {
  SwitchWidget({Key? key}) : super(key: key);

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  final widgets = [
    StatelessContainer(),
    StatelessContainer(),
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Builder(builder: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgets,
            ),
            Text("widgets is StatelessContainer, \n 点击Widget，发生切换")
          ],
        );
      }),
      onTap: () {
        setState(() {
          widgets.insert(0, widgets.removeAt(1));
        });
      },
    );
  }
}

class SwitchWidget2 extends StatefulWidget {
  const SwitchWidget2({Key? key}) : super(key: key);

  @override
  _SwitchWidget2State createState() => _SwitchWidget2State();
}

class _SwitchWidget2State extends State<SwitchWidget2> {
  final widgets = [
    StatefulContainer(),
    StatefulContainer(),
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Builder(builder: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgets,
            ),
            Text("widgets is StatefulContainer, \n点击Widget，未发生切换")
          ],
        );
      }),
      onTap: () {
        setState(() {
          widgets.insert(0, widgets.removeAt(1));
        });
      },
    );
  }
}

class SwitchWidget3 extends StatefulWidget {
  const SwitchWidget3({Key? key}) : super(key: key);

  @override
  _SwitchWidget3State createState() => _SwitchWidget3State();
}

class _SwitchWidget3State extends State<SwitchWidget3> {
  final widgets = [
    StatefulContainer(
      key: UniqueKey(),
    ),
    StatefulContainer(
      key: UniqueKey(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Builder(builder: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgets,
            ),
            Text(
                "widget is StatefulContainer(key: UniqueKey(),), \n 点击Widget，未发生切换")
          ],
        );
      }),
      onTap: () {
        setState(() {
          widgets.insert(0, widgets.removeAt(1));
        });
      },
    );
  }
}

class SwitchWidget4 extends StatefulWidget {
  const SwitchWidget4({Key? key}) : super(key: key);

  @override
  _SwitchWidget4State createState() => _SwitchWidget4State();
}

class _SwitchWidget4State extends State<SwitchWidget4> {
  final widgets = [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: StatefulContainer(
        key: UniqueKey(),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: StatefulContainer(
        key: UniqueKey(),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Builder(builder: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgets,
            ),
            Text(
                "widget is Padding->StatefulContainer(key: UniqueKey(),), \n 点击Widget，未发生切换，但被重新build了，如果把key提到Padding中，那么就可以切换并不rebuild")
          ],
        );
      }),
      onTap: () {
        setState(() {
          widgets.insert(0, widgets.removeAt(1));
        });
      },
    );
  }
}

class SwitchWidget5 extends StatefulWidget {
  const SwitchWidget5({Key? key}) : super(key: key);

  @override
  _SwitchWidget5State createState() => _SwitchWidget5State();
}

class _SwitchWidget5State extends State<SwitchWidget5> {
  final widgets = [
    Container(
      child: StatefulContainer(
        key: UniqueKey(),
      ),
    ),
    Container(
      child: StatefulContainer(
        key: UniqueKey(),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Builder(builder: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgets,
            ),
            Text(
                "widget is Container->StatefulContainer(key: UniqueKey(),), \n 点击Widget，未发生切换，但被重新build了，如果把key提到Container中，那么就可以切换并不rebuild")
          ],
        );
      }),
      onTap: () {
        setState(() {
          widgets.insert(0, widgets.removeAt(1));
        });
      },
    );
  }
}
