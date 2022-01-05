import 'dart:async';

import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  final String? a = null;

  void throwError() {
    // int.parse("source");
    a!.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("异常处理"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              MaterialButton(
                onPressed: () {
                  throwError();
                },
                child: Text("同步错误"),
              ),
              MaterialButton(
                onPressed: () {
                  // throwError();
                  Future.delayed(Duration(seconds: 1))
                      .then((e) => throwError());
                },
                child: Text("异步错误"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
