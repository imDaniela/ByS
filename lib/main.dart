import 'package:flutter/material.dart';
import 'package:bys_app/inicio_sesion/login_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String title = 'ByS';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: Colors.black),
    );

    return MaterialApp(
      title: title,
      theme: theme,
      home: const Scaffold(
        // appBar: AppBar(
        //     title: const Text(title),
        //     backgroundColor: const Color.fromRGBO(
        //         142, 11, 44, 1)), // Set the background color of the AppBar
        body: LoginScreen(),
      ),
    );
  }
}
