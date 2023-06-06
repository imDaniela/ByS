import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';

class LoginApi {
  static Future<http.Response?> LogAuth(
      String username, String password) async {
    print('loign');
    Map<String, String> body = {'codrep': username, 'password': password};
    print(body);
    print('${GlobalConstants.apiEndPoint}login');
    try {
      http.Response result = await http
          .post(Uri.parse('${GlobalConstants.apiEndPoint}login'), body: body);
      print(result.body);
      return result;
    } catch (ex) {
      print(ex);
    }
    return null;
  }

  static Future<http.Response> Users() async {
    print('get users');
    print('${GlobalConstants.apiEndPoint}get-users');
    http.Response result =
        await http.get(Uri.parse('${GlobalConstants.apiEndPoint}get-users'));
    return result;
  }
}
