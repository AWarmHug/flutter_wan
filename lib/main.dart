import 'dart:async';
import 'dart:io';
import 'package:date_format/date_format.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/login/login_home.dart';
import 'package:path_provider/path_provider.dart';

import 'myapp.dart';

import 'tools/navigator/main.dart' as Navigator2;

import 'tools/navigator/navigator1.dart' as Navigator1;

void collectLog(String line) {
  debugPrint("-----collectLog----$line");
}

void reportErrorAndLog(bool isSync, Object error, StackTrace? stack) async {
  debugPrint(
      "-----reportErrorAndLog-----isSync=$isSync----error=$error,stack=$stack");
  Directory directory = await getDirectory();
  DateTime now = DateTime.now();
  String txtName = formatDate(now, [yyyy, "-", mm, '-', dd]);
  File file = File("${directory.path}${Platform.pathSeparator}${txtName}.txt");
  IOSink ioSink = file.openWrite(mode: FileMode.append);

  ioSink.writeln(
      "════════════════════════════════════════════════════════════════════════════════════════════════════");
  ioSink.writeln(now);
  ioSink.writeln(error);
  ioSink.writeln(stack);
  await ioSink.flush();
  await ioSink.close();
}

Future<Directory> getDirectory() async {
  Directory directory = await getApplicationDocumentsDirectory();
  return directory;
}

void main() {
  var onError = FlutterError.onError; //先将 onerror 保存起来
  FlutterError.onError = (FlutterErrorDetails details) {
    onError?.call(details);
    reportErrorAndLog(true, details.exception, details.stack);
  };

  runZonedGuarded(() {
    runApp(MyApp());
  }, (Object error, StackTrace stack) {
    reportErrorAndLog(false, error, stack);
  }, zoneSpecification: ZoneSpecification());
}

@pragma('vm:entry-point')
void mainNavigator1() {
  runApp(Navigator1.MyApp());
}

@pragma('vm:entry-point')
void mainNavigator2() {
  runApp(Navigator2.MyApp());
}

@pragma('vm:entry-point')
void mainLogin() {
  runApp(LoginApp());
}