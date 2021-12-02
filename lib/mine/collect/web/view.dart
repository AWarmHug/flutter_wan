import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class WebPage extends StatelessWidget {
  final logic = Get.put(WebLogic());
  final state = Get.find<WebLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
