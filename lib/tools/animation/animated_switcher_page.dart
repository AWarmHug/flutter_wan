import 'package:flutter/material.dart';

class AnimatedSwitcherPage extends StatelessWidget {
  const AnimatedSwitcherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimationSwitcher"),
      ),
      body: Container(
        child: AnimatedSwitcherWidget(),
      ),
    );
  }
}

class AnimatedSwitcherWidget extends StatefulWidget {
  const AnimatedSwitcherWidget({Key? key}) : super(key: key);

  @override
  _AnimatedSwitcherWidgetState createState() => _AnimatedSwitcherWidgetState();
}

class _AnimatedSwitcherWidgetState extends State<AnimatedSwitcherWidget> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              child: child,
              scale: animation,
            );
          },
          child: Text(
            "${_count}",
            key: ValueKey(_count),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _count += 1;
            });
          },
          child: Text("+1"),
        ),
      ],
    );
  }
}
