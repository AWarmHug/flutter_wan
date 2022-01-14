import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '欢迎光临',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "账号",
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "密码",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/catalog");
                },
                child: Text("登录"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
