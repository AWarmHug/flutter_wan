import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/route.dart';
import 'package:flutter_wan/tools/animation/tween_page.dart';

import 'animated_decorated_box_page.dart';
import 'animated_switcher_page.dart';
import 'hero_animation_page.dart';
import 'route_animation_page.dart';
import 'stagger_animation_page.dart';

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
              MyRouter.to(
                context,
                TweenPage(),
              );
            },
            child: Text("Tween"),
          ),
          TextButton(
            onPressed: () {
              MyRouter.to(
                context,
                RouteAnimationPage(),
              );
            },
            child: Text("RouteAnimation"),
          ),
          TextButton(
            onPressed: () {
              MyRouter.to(
                context,
                HeroPage(),
              );
            },
            child: Text("Hero"),
          ),
          TextButton(
            onPressed: () {
              MyRouter.to(
                context,
                StaggerAnimationPage(),
              );
            },
            child: Text("StaggerAnimationPage"),
          ),
          TextButton(
            onPressed: () {
              MyRouter.to(
                context,
                AnimatedSwitcherPage(),
              );
            },
            child: Text("AnimatedSwitcherPage"),
          ),
          TextButton(
            onPressed: () {
              MyRouter.to(
                context,
                AnimatedDecoratedBoxPage(),
              );
            },
            child: Text("AnimatedDecoratedBoxPage"),
          ),
        ],
      ),
    );
  }
}
