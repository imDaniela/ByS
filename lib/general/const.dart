import 'package:bys_app/inicio_sesion/model/login_resp.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:bys_app/productos/models/producto.dart';
import 'package:timezone/timezone.dart' as tz;

//const fakeEndPoint = 'http://127.0.0.1:8080/';

class GlobalConstants {
  //static String apiEndPoint = "http://192.168.0.200:3000/";
  static String apiEndPoint = "http://192.168.18.7:3001/";

  static String? token;
  static String? id;
  static String? email;
  static String? name;
  static DateFormat format = DateFormat('d-M-y');
  static DateFormat format_with_time = DateFormat('d-M-y HH:mm');

  static List<Producto> productos = [];
  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  static void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {}
    /*await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
    );*/
  }

  static void InitNotifications() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: (num, str, str2, str3) => {});
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            macOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    await flutterLocalNotificationsPlugin!.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  static Producto? findProducto(int codart) {
    try {
      return productos.firstWhere((element) => element.codart == codart);
    } catch (ex) {
      return null;
    }
  }

  static String getHoyString({bool time = false}) {
    DateTime now = DateTime.now();
    if (time) {
      return format_with_time.format(now);
    }

    return format.format(now);
  }

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

  static Future<void> deleteNotification(int id) async {
    try {
      await flutterLocalNotificationsPlugin!.cancel(id);
    } catch (ex) {}
  }

  static void ScheduleNotification(
      String body, String title, DateTime date, int id) async {
    await deleteNotification(id);
    await flutterLocalNotificationsPlugin!.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(date, tz.local),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
