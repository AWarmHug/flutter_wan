import 'dart:async';

import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  void collectLog(String line) {
    debugPrint("-----collectLog----$line");
  }

  void reportErrorAndLog(FlutterErrorDetails details) {
    debugPrint("-----reportErrorAndLog----$details");
  }

 final String? a=null;

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
              Text(""),
              MaterialButton(
                onPressed: () {
                  var onError = FlutterError.onError; //先将 onerror 保存起来
                  FlutterError.onError = (FlutterErrorDetails details) {
                    onError?.call(details);
                    reportErrorAndLog(details);
                  };

                  runZoned(
                    () {
                      // throwError();
                      Future.delayed(Duration(seconds: 1)).then((e) => throwError());

                    },
                    zoneSpecification: ZoneSpecification(
                      print: (self, parent, zone, line) {
                        collectLog(line);
                        parent.print(zone, "Interceptor: $line");
                      },
                      handleUncaughtError:
                          (self, parent, zone, error, stackTrace) {
                        // reportErrorAndLog(details);
                        parent.print(zone, '${error.toString()} $stackTrace');
                      },
                    ),
                  );
                },
                child: Text("点我报错"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
