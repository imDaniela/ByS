import 'dart:convert';

import 'package:bys_app/inicio_sesion/model/User.dart';

class LoginResp {
  String? token;
  User? user;
  LoginResp({
    this.token,
    this.user,
  });

  LoginResp copyWith({
    String? token,
    User? user,
  }) {
    return LoginResp(
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (token != null) {
      result.addAll({'token': token});
    }
    if (user != null) {
      result.addAll({'user': user!.toMap()});
    }

    return result;
  }

  factory LoginResp.fromMap(Map<String, dynamic> map) {
    return LoginResp(
      token: map['token'],
      user: map['user'] != null ? User.fromMap(map['user']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResp.fromJson(String source) =>
      LoginResp.fromMap(json.decode(source));

  @override
  String toString() => 'LoginResp(token: $token, user: $user)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginResp && other.token == token && other.user == user;
  }

  @override
  int get hashCode => token.hashCode ^ user.hashCode;
}
