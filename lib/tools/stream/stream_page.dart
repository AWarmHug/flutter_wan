//streamController：管理调度整个事件流的流程，并保存整个事件流中所需要的对象，便于管理和使用
//
// StreamSink：事件的开始入口，所有的同步异步事件都是从这里开始的，提供了add 和addStream等方法
//
// Steam：事件本身，可以被转换和监听，订阅后返回StreamSubscription对象
//
// StreamSubscription：订阅steam后得到的对象，可以管理订阅过的各种操作，如cancle（）、 pause（）
// ————————————————
// 版权声明：本文为CSDN博主「小楼一夜听风来」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
// 原文链接：https://blog.csdn.net/qq_33726122/article/details/109673829

import 'dart:async';

import 'package:flutter/material.dart';

class StreamPage extends StatefulWidget {
  const StreamPage({Key? key}) : super(key: key);

  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
 late StreamController<int> _streamController;

 int counter=0;


  @override
  void initState() {
    _streamController=StreamController();
    super.initState();
  }


  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StreamBuilder"),
      ),
      body: Container(
        child: Column(
          children: [
            StreamBuilder<int>(
              initialData: counter,
              stream: _streamController.stream,
              builder: (context, snapshot) {
                return Text("${snapshot.data}");
              },
            ),
            TextButton(
              onPressed: () {
                counter++;
                _streamController.add(counter);
              },
              child: Text("点我"),
            ),
          ],
        ),
      ),
    );
  }
}
