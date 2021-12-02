part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class RegEvent extends LoginEvent {
  final String username;
  final String password;
  final String repassword;

  RegEvent(this.username, this.password, this.repassword);

  @override
  List<Object?> get props => [];
}

class LoginEventLogin extends LoginEvent {
  final String username;
  final String password;

  LoginEventLogin(this.username, this.password);

  @override
  List<Object?> get props => [username,password];
}