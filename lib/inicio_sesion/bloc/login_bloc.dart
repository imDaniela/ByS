import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bys_app/inicio_sesion/model/user.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';
import 'package:bys_app/inicio_sesion/api/login_api.dart';
import 'package:bys_app/inicio_sesion/model/login_resp.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<AuthenticateCredentias>((event, emit) async {
      if (state is LoginInitial) {
        String? username = event.username;
        String? password = event.password;
        LoginInitial anterior = state as LoginInitial;
        if (username == null || username == "") {
          emit(LoginError("You must write a username or email"));
          emit(anterior);
        } else if (password == null || password == "") {
          emit(LoginError("You must write a password"));
          emit(anterior);
        } else {
          emit(LogInLoading());
          http.Response? resp = await LoginApi.LogAuth(username, password);
          if (resp?.statusCode == 200 || resp?.statusCode == 201) {
            LoginResp json_resp = LoginResp.fromJson(resp?.body ?? '');
            GlobalConstants.storeInSharedPreferenced(json_resp);
            emit(LogedIn(usuarios: state.usuarios));
            add(getUsersList());
          } else {
            try {
              dynamic json_resp = jsonDecode(resp?.body ?? '');
              emit(LoginError(json_resp['message'][0]));
            } catch (ex) {
              emit(LoginError('Network Error'));
            }
            emit(anterior);
          }
        }
      } else {
        emit(LoginInitial());
      }
    });

    on<LoadToken>((event, emit) async {
      if (await GlobalConstants.LoadSharedPreferences()) {
        emit(LogedIn());
      }
      add(getUsersList());
    });
    on<LogOut>((event, emit) async {
      emit(LoginInitial());
      add(getUsersList());
      GlobalConstants.cleanSharedPreferences();
    });
    on<getUsersList>((event, emit) async {
      List<User>? usuarios = null;
      try {
        http.Response? resp = await LoginApi.Users();
        if (resp != null) {
          if (resp.statusCode == 200) {
            usuarios = await User.fromJsonList(resp.body);
          }
        }
        print(usuarios);
        if (state is LogedIn) {
          emit(LogedIn(usuarios: usuarios));
        } else {
          emit(LoginInitial(usuarios: usuarios));
        }
      } catch (ex) {
        await Future.delayed(const Duration(milliseconds: 500));
        print('a');
        add(getUsersList());
      }
    });
  }
}
