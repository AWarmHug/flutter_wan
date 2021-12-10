import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AnswerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AnswerLogic());
    final state = Get.find<AnswerLogic>().state;

    return Container();
  }
}
