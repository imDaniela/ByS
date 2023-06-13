import 'package:bys_app/clientes_del_dia/day_selector.dart';
import 'package:bys_app/clientes_del_dia/historial_cliente/bloc/history_bloc.dart';
import 'package:bys_app/clientes_del_dia/list_screen.dart';
import 'package:bys_app/clientes_del_dia/client_screen.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:bys_app/inicio_sesion/bloc/login_bloc.dart';
import 'package:bys_app/inicio_sesion/model/ClientesDia.dart';
import 'package:bys_app/pedidos/bloc/pedidos_bloc.dart';
import 'package:bys_app/pedidos/pedidos.dart';
import 'package:bys_app/pedidos/zonacliente.dart';
import 'package:bys_app/productos/bloc/productos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bys_app/inicio_sesion/screen/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String title = 'ByS';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(backgroundColor: Colors.black),
    );

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc()..add(LoadToken())),
          BlocProvider(create: (context) => ClientesdiaBloc()),
          BlocProvider(create: (context) => PedidosBloc()),
          BlocProvider(create: (context) => ProductosBloc()),
          BlocProvider(create: (context) => HistoryBloc())
        ],
        child: MaterialApp(
          title: title,
          theme: theme,
          routes: {
            'login': (context) => LoginScreen(),
            'dias': (context) => DayScreen(),
            'client': (context) => ClientScreen(),
            'pedidos': (context) => PedidosScreen(),
            'zona_clientes': (context) => ZonaCliente(),
          },
          home: const Scaffold(
            // appBar: AppBar(
            //     title: const Text(title),
            //     backgroundColor: const Color.fromRGBO(
            //         142, 11, 44, 1)), // Set the background color of the AppBar
            body: LoginScreen(),
          ),
        ));
  }
}
