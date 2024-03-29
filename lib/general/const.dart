import 'package:bys_app/inicio_sesion/model/login_resp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:bys_app/productos/models/producto.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/cupertino.dart';

//const fakeEndPoint = 'http://127.0.0.1:8080/';

class GlobalConstants {
  static String apiEndPoint = "http://192.168.0.200:3000/";
  //static String apiEndPoint = "http://192.168.18.5:3000/";

  //static String apiEndPoint = "http://192.168.1.29:3001/";
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldState =
      GlobalKey<ScaffoldMessengerState>();

  static String? token;
  static String? id;
  static String? email;
  static String? name;
  static int? rol;
  static int? codrep;
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

  static Producto? findProducto(String codart) {
    try {
      print(codart);
      Producto? producto =
          productos.firstWhere((element) => element.codart == codart);
      print(producto);
      return producto;
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
    Map<String, String> result = {
      'x-access-token': "${token}",
      'Content-Type': "application/json",
    };
    if (codrep != null) {
      result.addAll({'codrep': codrep!.toString()});
    }
    return result;
  }

  static void storeInSharedPreferenced(LoginResp resp) async {
    token = resp.token;
    id = resp.user?.CODREP.toString();
    rol = resp.user?.id_rol;
    name = resp.user?.NOM;
    final shar = await SharedPreferences.getInstance();
    if (token != null) {
      shar.setString('token', token!);
    }
    if (rol != null) {
      shar.setInt('rol', rol!);
      print(rol);
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
    rol = shar.getInt('rol');
    print(rol);
    codrep = null;
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
