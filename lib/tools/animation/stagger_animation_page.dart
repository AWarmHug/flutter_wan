import 'package:flutter/material.dart';

class StaggerAnimationPage extends StatefulWidget {
  const StaggerAnimationPage({Key? key}) : super(key: key);

  @override
  State<StaggerAnimationPage> createState() => _StaggerAnimationPageState();
}

class _StaggerAnimationPageState extends State<StaggerAnimationPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("交织动画"),
      ),
      body: InkWell(
        onTap: () {
          if(_controller.isCompleted){
            _controller.reverse();
          }else {
            _controller.forward();
          }
        },
        child: Container(
          height: 400,
          child: StaggerAnimationWidget(
            controller: _controller,
          ),
          color: Colors.black26,
        ),
      ),
    );
  }
}

class StaggerAnimationWidget extends StatelessWidget {
    StaggerAnimationWidget({Key? key, required this.controller})
      : super(key: key) {
    height = Tween<double>(
      begin: 0.0,
      end: 300.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.0,
        0.6,
        curve: Curves.linear,
      ),
    ));
    color = ColorTween(
      begin: Colors.black54,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.6,
        1.0,
        curve: Curves.linear,
      ),
    ));
  }

  final AnimationController controller;
  late Animation<double> height;
  late Animation<Color?> color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? child) {
            return Container(
              color: color.value,
              width: 50.0,
              height: height.value,
            );
          }),
    );
  }
}
