import 'package:flutter/material.dart';

class RouteAnimationPage extends StatelessWidget {
  const RouteAnimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("路由"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(pageBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return FadeTransition(
                    opacity: animation,
                    child: EmptyPage(),
                  );
                }),
              );
            },
            child: Text("FadeTransition"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(pageBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return ScaleTransition(
                    scale: animation,
                    child: EmptyPage(),
                  );
                }),
              );
            },
            child: Text("ScaleTransition"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(pageBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return RotationTransition(
                    turns: animation,
                    child: EmptyPage(),
                  );
                }),
              );
            },
            child: Text("RotationTransition"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(pageBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  Animation<Offset> offset =
                      Tween(begin: Offset(1, 0), end: Offset(0, 0))
                          .animate(animation);
                  return SlideTransition(
                    position: offset,
                    child: EmptyPage(),
                  );
                }),
              );
            },
            child: Text("SlideTransition"),
          ),
        ],
      ),
    );
  }
}

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("空白"),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.blue.shade300,
      ),
    );
  }
}

