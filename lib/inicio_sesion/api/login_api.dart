import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';

class LoginApi {
  static Future<http.Response?> LogAuth(
      String username, String password) async {
    Map<String, String> body = {'codrep': username, 'password': password};
    try {
      http.Response result = await http
          .post(Uri.parse('${GlobalConstants.apiEndPoint}login'), body: body);
      return result;
    } catch (ex) {}
    return null;
  }

  static Future<http.Response> Users() async {
    http.Response result =
        await http.get(Uri.parse('${GlobalConstants.apiEndPoint}get-users'));
    print(result.body);
    return result;
  }
}
