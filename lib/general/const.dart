import 'package:bys_app/inicio_sesion/model/login_resp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalConstants {
  static String apiEndPoint = "http://192.168.18.5:8000/";
  static String? token;
  static String? id;
  static String? email;
  static String? name;
  static int getHoy() {
    DateTime now = DateTime.now();

    // Get the day of the week as a number (1-7)
    int dayOfWeek = now.weekday;
    return dayOfWeek;
  }

  static Map<String, String> header() {
    return {'x-access-token': "${token}", 'Content-Type': "application/json"};
  }

  static void storeInSharedPreferenced(LoginResp resp) async {
    token = resp.token;

    final shar = await SharedPreferences.getInstance();
    if (token != null) {
      shar.setString('token', token!);
    }
    if (id != null) {
      shar.setString('id', id!);
    }
    if (name != null) {
      shar.setString('name', name!);
    }
    if (email != null) {
      shar.setString('email', email!);
    }
  }

  static Future<bool> LoadSharedPreferences() async {
    final shar = await SharedPreferences.getInstance();

    token = shar.getString('token');
    id = shar.getString('id');
    name = shar.getString('name');
    email = shar.getString('email');
    return token != null;
  }

  static Future<bool> cleanSharedPreferences() async {
    final shar = await SharedPreferences.getInstance();

    return shar.clear();
  }
}
