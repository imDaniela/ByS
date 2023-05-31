import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';
import 'package:bys_app/inicio_sesion/bloc/login_bloc.dart';

class LoginApi {
  static Future<http.Response> LogAuth(String username, String password) async {
    print('loign');
    Map<String, dynamic> body = {'email': username, 'password': password};
    http.Response result = await http
        .post(Uri.parse('${GlobalConstants.apiEndPoint}login'), body: body);
    return result;
  }
}
