part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoadToken extends LoginEvent {
  LoadToken();
}

class AuthenticateCredentias extends LoginEvent {
  AuthenticateCredentias();
}

class LogOut extends LoginEvent {}

class LoginAddData extends LoginEvent {
  String? username;
  String? password;
  LoginAddData({this.username, this.password});
}

class getUsersList extends LoginEvent {}
