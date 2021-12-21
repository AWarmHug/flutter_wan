import 'package:flutter/material.dart';

class TweenPage extends StatefulWidget {
  const TweenPage({Key? key}) : super(key: key);

  @override
  _TweenPageState createState() => _TweenPageState();
}

class _TweenPageState extends State<TweenPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late StateSetter animateSetState;

  late Animation<Color?> colorAnimation;
  late Animation<double> scaledAnimation;
  late Animation<Offset> slideAnimation;
  late Animation<double> rotationAnimation;
  late Animation<double> sizeAnimation;
  late Animation<double> fadeAnimation;

  late Animation<RelativeRect> relativeRectTween;

  late Animation<Rect?> rectAnimation;
  late Animation<Decoration> decorationAnimation;
  late Animation<AlignmentGeometry> alignmentAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: 20.0, end: 100.0).animate(controller)
      ..addListener(() {
        // animateSetState(() {});
      });

    colorAnimation =
        ColorTween(begin: Colors.red, end: Colors.black).animate(controller);
    scaledAnimation = Tween(begin: 0.2, end: 1.0).animate(controller);
    slideAnimation =
        Tween(begin: Offset.zero, end: Offset(2, 1)).animate(controller);
    rotationAnimation = Tween(begin: 0.0, end: 2.0).animate(controller);
    sizeAnimation = Tween(begin: 0.5, end: 1.5).animate(controller);
    fadeAnimation = Tween(begin: 0.5, end: 1.0).animate(controller);
    relativeRectTween = RelativeRectTween(
            begin: RelativeRect.fromLTRB(50.0, 50.0, 50.0, 50.0),
            end: RelativeRect.fill)
        .animate(controller);
    rectAnimation = RectTween(
      begin: Rect.fromLTRB(10.0, 10.0, -10.0, -10.0),
      end: Rect.fromLTRB(50, 50, 0, 0),
    ).animate(controller);
    decorationAnimation = DecorationTween(
      begin: BoxDecoration(),
      end: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              offset: Offset(-10, -10),
              blurRadius: 10,
              spreadRadius: 10),
        ],
      ),
    ).animate(controller);
    alignmentAnimation =
        AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight)
            .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tween"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0, //宽高比为1时，子widget
        children: [
          InkWell(
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: SizedBox(
              child: Center(
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    animateSetState = setState;

                    return Container(
                      color: Colors.red,
                      width: animation.value,
                      height: animation.value,
                    );
                  },
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: SizedBox(
              child: Center(
                child: AnimatedImage(animation: animation),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: SizedBox(
              child: Center(
                child: AnimatedBuilder(
                  animation: animation,
                  child: Container(
                    color: Colors.red,
                  ),
                  builder: (context, child) {
                    return Container(
                      width: animation.value,
                      height: animation.value,
                      child: child,
                    );
                  },
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: SizedBox(
              child: Center(
                child: GrowTransition(
                  animation: animation,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: SizedBox(
              child: AnimatedBuilder(
                animation: colorAnimation,
                builder: (context, child) {
                  return Container(
                    alignment: Alignment.center,
                    color: colorAnimation.value,
                    child: Text(
                      "颜色",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: SizedBox(
              child: Container(
                alignment: Alignment.topLeft,
                child: SlideTransition(
                  position: slideAnimation,
                  child: Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    color: Colors.red,
                    child: Text(
                      "移动:SlideTransition",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: SizedBox(
              child: ScaleTransition(
                scale: scaledAnimation,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: Text(
                    "缩放:ScaleTransition",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: SizedBox(
              child: RotationTransition(
                turns: rotationAnimation,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: Text(
                    "旋转:RotationTransition",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: Container(
              alignment: Alignment.topLeft,
              color: Colors.blue,
              height: 150,
              child: SizeTransition(
                sizeFactor: sizeAnimation,
                axis: Axis.horizontal,
                child: Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: Text(
                    "运动尺寸:SizeTransition",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: SizedBox(
              child: FadeTransition(
                opacity: fadeAnimation,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: Text(
                    "渐变:FadeTransition",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: Stack(
              children: [
                PositionedTransition(
                  rect: relativeRectTween,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.red,
                    child: Text(
                      "绝对移动:PositionedTransition",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: Stack(
              children: [
                RelativePositionedTransition(
                  rect: rectAnimation,
                  size: Size(0.0, 0.0),
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.red,
                    child: Text(
                      "相对移动:RelativePositionedTransition",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: Container(
              alignment: Alignment.center,
              child: DecoratedBoxTransition(
                decoration: decorationAnimation,
                child: Container(
                  width: 120,
                  height: 120,
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: Text(
                    "装饰:DecoratedBoxTransition",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.reset();
              controller.forward();
            },
            child: Container(
              alignment: Alignment.center,
              child: AlignTransition(
                alignment: alignmentAnimation,
                child: Container(
                  width: 120,
                  height: 120,
                  color: Colors.red,
                  child: Text(
                    "相对定位:AlignTransition",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Container(
      color: Colors.red,
      width: animation.value,
      height: animation.value,
    );
  }
}

class GrowTransition extends StatelessWidget {
  const GrowTransition({Key? key, required this.animation, required this.child})
      : super(key: key);

  final Animation<double> animation;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return Container(
          height: animation.value,
          width: animation.value,
          child: child,
        );
      },
    );
  }
}

class ScaledWidget extends StatefulWidget {
  const ScaledWidget(
      {Key? key, required this.begin, required this.end, required this.child})
      : super(key: key);

  final double begin;
  final double end;
  final Widget child;

  @override
  _ScaledWidgetState createState() => _ScaledWidgetState();
}

class _ScaledWidgetState extends State<ScaledWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    _animation =
        Tween(begin: widget.begin, end: widget.end).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: _animation.value,
          height: _animation.value,
          child: widget.child,
        );
      },
    );
  }
}
