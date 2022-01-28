import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wan/data/user.dart';
import 'package:flutter_wan/global.dart';
import 'package:flutter_wan/resource/app_images.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../common_state.dart';
import '../method_channels.dart';
import '../status.dart';
import 'login_bloc.dart';
import 'package:flutter_wan/route.dart';

class LoginApp extends StatelessWidget {
  LoginApp({Key? key}) : super(key: key);

  final MyRouterDelegate _routerDelegate = MyRouterDelegate();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        theme: ThemeData.light(),
        routeInformationParser: MyRouteInformationParser(),
        routerDelegate: _routerDelegate);
  }
}

class LoginHome extends StatefulWidget {
  const LoginHome({Key? key}) : super(key: key);

  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  TextEditingController nickNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocListener<LoginBloc, CommonState>(
        listener: (context, state) {
          if (state is CommonStateResult) {
            if (state.result is UserInfo) {
              UserInfo userInfo = state.result;
              if (state.status == Status.SUCCESS) {
                //登录成功
                MethodChannels.setLoginStatus(true);
                MyRouter.back(context);
              } else {
                  Fluttertoast.showToast(msg: "登录失败！");
              }
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("登录"),
            actions: [
              InkWell(
                onTap: () {
                  MyRouter.toNamed(context, "/login/reg");
                },
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Icon(Icons.how_to_reg),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppImages.logo,
                      width: 160,
                      height: 80,
                    ),
                  ),
                  TextField(
                    controller: nickNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.5,
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 12, top: 8, right: 12, bottom: 8),
                      hintText: "请输入昵称",
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0.5, color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 12, top: 8, right: 12, bottom: 8),
                      hintText: "请输入密码",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<LoginBloc, CommonState>(
                    builder: (context, state) {
                      return TextButton(
                        onPressed: () {
                          LoginBloc bloc = context.read();
                          bloc.add(LoginEventLogin(nickNameController.text,
                              passwordController.text));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Theme.of(context).primaryColor,
                          ),
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          child: Center(
                            child: Text(
                              "登录",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
