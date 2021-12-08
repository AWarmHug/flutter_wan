import 'package:flutter/material.dart';
import 'package:flutter_wan/data/tree.dart';

class VTabs extends StatefulWidget {
  final List<Tree> trees;

  final ValueChanged<int> valueChanged;

  const VTabs(this.trees, {required this.valueChanged, Key? key})
      : super(key: key);

  @override
  _VTabsState createState() => _VTabsState();
}

class _VTabsState extends State<VTabs> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // widget.valueChanged(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              widget.valueChanged(_selectedIndex);
            },
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(),
              padding: EdgeInsets.only(left: 6, top: 4, right: 2, bottom: 4),
              child: Text(
                widget.trees[index].name!,
                style: _textStyle(context, index),
              ),
            ),
          );
        },
        itemCount: widget.trees.length,
      ),
    );
  }

  TextStyle? _textStyle(BuildContext context, int index) {
    if (_selectedIndex == index) {
      return TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold);
    } else {
      return TextStyle(color: Colors.white60, fontSize: 14);
    }
  }
}
