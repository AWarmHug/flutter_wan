import 'package:flutter/material.dart';

import 'custom_paint_page.dart';

class CustomPage extends StatelessWidget {
  const CustomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("自定义"),
      ),
      body: Container(
        child: ListView(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CustomPaintPage();
                    },
                  ),
                );
              },
              child: Text("CustomPaintPage"),
            ),
          ],
        ),
      ),
    );
  }
}
