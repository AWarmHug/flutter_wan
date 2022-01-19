import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertDialogScreen extends StatelessWidget {
  const AlertDialogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AlertDialog"),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("标题",textAlign: TextAlign.center,),
                    content: Text("内容内容内容内容内容内容内容"),
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8)) ),
                  );
                },
              );
            },
            child: Text("AlertDialog"),
          ),
        ),
      ),
    );
  }
}
class EAlertDialog extends StatelessWidget {
  const EAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
