import 'package:flutter/material.dart';

class StaggerAnimationPage extends StatelessWidget {

  const StaggerAnimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("交织动画"),
      ),
      body: Container(
        height: 400,
        child: StaggerAnimationWidget(),
        color: Colors.black26,
      ),
    );
  }
}

class StaggerAnimationWidget extends StatelessWidget {
  const StaggerAnimationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(



    );
  }
}

