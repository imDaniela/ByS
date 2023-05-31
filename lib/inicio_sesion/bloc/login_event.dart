part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoadToken extends LoginEvent {
  LoadToken();
}

class LogOut extends LoginEvent {}

class AuthenticateCredentias extends LoginEvent {
  String? username;
  String? password;
  AuthenticateCredentias({this.username, this.password});
}

class getUsersList extends LoginEvent {}
