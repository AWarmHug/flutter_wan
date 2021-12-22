import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroPage extends StatelessWidget {
  const HeroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero动画"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => HeroMockPage(),
                ),
              );
            },
            child: Text("HeroMockPage"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => HeroAnimationPage(),
                ),
              );
            },
            child: Text("HeroAnimationPage"),
          ),
        ],
      ),
    );
  }
}

class HeroMockPage extends StatefulWidget {
  const HeroMockPage({Key? key}) : super(key: key);

  @override
  _HeroMockPageState createState() => _HeroMockPageState();
}

class _HeroMockPageState extends State<HeroMockPage>
    with SingleTickerProviderStateMixin {
  late Animation<RelativeRect> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(100, 20, 100, 300),
      end: RelativeRect.fromLTRB(0, 100, 0, 100),
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("模拟Hero动画"),
      ),
      body: Container(
        child: InkWell(
          onTap: () {
            if (_controller.isCompleted) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
          },
          child: Stack(
            children: [
              PositionedTransition(
                rect: _animation,
                child: Image.network(
                  "https://c-ssl.duitang.com/uploads/item/201912/28/20191228105602_4Wm5z.thumb.1000_0.jpeg",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeroAnimationPage extends StatelessWidget {
  const HeroAnimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            InkWell(
              child: Hero(
                tag: "avatar",
                child: ClipOval(
                  child: Image.network(
                    "https://c-ssl.duitang.com/uploads/item/201912/28/20191228105602_4Wm5z.thumb.1000_0.jpeg",
                    width: 50,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: Scaffold(
                          appBar: AppBar(
                            title: Text("原图"),
                          ),
                          body: Container(
                            child: Center(
                              child: Hero(
                                tag: "avatar",
                                child: Image.network(
                                  "https://c-ssl.duitang.com/uploads/item/201912/28/20191228105602_4Wm5z.thumb.1000_0.jpeg",
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
