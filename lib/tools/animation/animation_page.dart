import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/tools/animation/tween_page.dart';

import 'route_animation_page.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("动画"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => TweenPage(),
                ),
              );
            },
            child: Text("Tween"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => RouteAnimationPage(),
                ),
              );
            },
            child: Text("RouteAnimation"),
          ),
        ],
      ),
    );
  }
}
