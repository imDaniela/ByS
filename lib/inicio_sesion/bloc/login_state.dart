part of 'login_bloc.dart';

@immutable
abstract class LoginState {
  List<User>? usuarios;
}

class LoginInitial extends LoginState {
  List<User>? usuarios;
  LoginInitial({this.usuarios}) : super();
}

class LogInLoading extends LoginState {
  LogInLoading() : super();
}

class LoginError extends LoginState {
  final String msg;
  LoginError(this.msg) : super();
}

class LogedIn extends LoginState {
  List<User>? usuarios;

  LogedIn({this.usuarios}) : super();
}

class Users extends LoginState {
  List<String>? list;
}
