import 'package:flutter/material.dart';

class FuturePage extends StatelessWidget {
  const FuturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FutureBuilder"),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder<String>(
            future: loadFromNet(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                if (snapshot.hasData) {
                  return Text("data: ${snapshot.data!}");
                }else{
                  return Text("error: ${snapshot.error}");
                }
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Future<String> loadFromNet() {
    return Future.value(Future.delayed(Duration(seconds: 3), () {
      return "from net";
    }));
  }
}
