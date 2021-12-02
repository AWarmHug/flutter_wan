import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_wan/common_state.dart';
import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/user.dart';
import 'package:flutter_wan/http.dart';

import '../global.dart';

part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, CommonState> {
  LoginBloc() : super(CommonInitial());

  @override
  Stream<CommonState> mapEventToState(
    LoginEvent event,
  ) async* {
    yield CommonStateResult.loading();
    if (event is RegEvent) {
      ResponseWan<UserInfo> user = await Http.post<UserInfo>("user/register", {
        "username": event.username,
        "password": event.password,
        "repassword": event.repassword,
      });
      if (user.isSuccess) {
        yield CommonStateResult.success(user.data);
      } else {
        yield CommonStateResult.error();
      }
    }
    if (event is LoginEventLogin) {
      ResponseWan<UserInfo> user = await Http.post<UserInfo>("user/login", {
        "username": event.username,
        "password": event.password,
      });
      if (user.isSuccess) {
        // todo 登录成功，保持状态
        Global.isLogin.value = true;
        yield CommonStateResult.success(user.data);
      } else {
        yield CommonStateResult.error();
      }
    }
  }
}
