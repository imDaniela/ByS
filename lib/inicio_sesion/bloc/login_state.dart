part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {
  String? username;
  String? password;
  LoginInitial({this.username, this.password}) : super();
  LoginInitial CopyWith({String? username, String? password}) {
    return LoginInitial(
        password: password ?? this.password,
        username: username ?? this.username);
  }
}

class LogInLoading extends LoginState {
  LogInLoading() : super();
}

class LoginError extends LoginState {
  final String msg;
  LoginError(this.msg) : super();
}

class LogedIn extends LoginState {
  LogedIn() : super();
}

class Users extends LoginState {
  List<String>? list;
}
