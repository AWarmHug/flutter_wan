import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_wan/data/user.dart';
import 'package:flutter_wan/resource/app_images.dart';
import 'package:flutter_wan/status.dart';
import 'package:get/get.dart';

import '../common_state.dart';
import 'login_bloc.dart';

class RegHome extends StatefulWidget {
  const RegHome({Key? key}) : super(key: key);

  @override
  _RegHomeState createState() => _RegHomeState();
}

class _RegHomeState extends State<RegHome> {
  TextEditingController nickNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

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
                print("注册成功");
                Get.offNamed("/login/login");
              } else {}
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("注册"),
            titleSpacing: 0,
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
                      hintText: "请输入昵称",
                      contentPadding: EdgeInsets.only(
                          left: 12, top: 8, right: 12, bottom: 8),
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
                      hintText: "请输入密码",
                      contentPadding: EdgeInsets.only(
                          left: 12, top: 8, right: 12, bottom: 8),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: repasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0.5, color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      hintText: "请确认密码",
                      contentPadding: EdgeInsets.only(
                          left: 12, top: 8, right: 12, bottom: 8),
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
                          bloc.add(RegEvent(
                              nickNameController.text,
                              passwordController.text,
                              repasswordController.text));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Theme.of(context).primaryColor,
                          ),
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          child: Center(
                            child: Text(
                              "注册",
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
