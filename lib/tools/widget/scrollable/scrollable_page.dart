import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_wan/tools/key/simple_demo_page.dart';

class ScrollablePage extends StatelessWidget {
  const ScrollablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      body: Container(
        child: RefreshView(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return SizedBox(
                height: 200,
                child: Container(
                  color: RandomColor().randomColor(),
                ),
              );
            },
            itemCount: 5,
          ),
          footer: SizedBox(
            height: 200,
            child: Container(
              color: RandomColor().randomColor(),
              child: Center(
                child: Text("footer"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RefreshView extends StatefulWidget {
  const RefreshView({Key? key, required this.child, required this.footer})
      : super(key: key);
  final Widget child;
  final Widget footer;

  @override
  _RefreshViewState createState() => _RefreshViewState();
}

class _RefreshViewState extends State<RefreshView> {
  @override
  Widget build(BuildContext context) {
    var footer = SliverPadding(padding: EdgeInsets.zero, sliver: widget.footer);

    return Container(
      child: Scrollable(
        viewportBuilder: (context, position) {
          return Viewport(
            offset: position,
            cacheExtentStyle: CacheExtentStyle.pixel,
            slivers: [
              // widget.child,
              footer,
            ],
          );
        },
      ),
    );
  }
}
