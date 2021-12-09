import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class QuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(QuestionLogic());
    final state = Get.find<QuestionLogic>().state;

    return Container(
      child: Center(
        child: Text("问答"),
      ),
    );
  }
}
