import 'package:bys_app/albaran_pendiente_por_facturar/albaran_screen.dart';
import 'package:bys_app/albaran_pendiente_por_facturar/bloc/albaran_bloc.dart';
import 'package:bys_app/alertas/alertas_screen.dart';
import 'package:bys_app/alertas/bloc/alertas_bloc.dart';
import 'package:bys_app/clientes_del_dia/day_selector.dart';
import 'package:bys_app/clientes_del_dia/historial_cliente/bloc/history_bloc.dart';
import 'package:bys_app/clientes_del_dia/list_screen.dart';
import 'package:bys_app/clientes_del_dia/client_screen.dart';
import 'package:bys_app/cobros/bloc/cobros_bloc.dart';
import 'package:bys_app/general/const.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:bys_app/inicio_sesion/bloc/login_bloc.dart';
import 'package:bys_app/inicio_sesion/model/ClientesDia.dart';
import 'package:bys_app/pedidos/bloc/pedidos_bloc.dart';
import 'package:bys_app/pedidos/pedidos.dart';
import 'package:bys_app/pedidos/pedidos_dia/bloc/pedidos_dia_bloc.dart';
import 'package:bys_app/pedidos/pedidos_dia/pedidos_screen.dart';
import 'package:bys_app/pedidos/zonacliente.dart';
import 'package:bys_app/productos/bloc/productos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bys_app/inicio_sesion/screen/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String title = 'ByS';

  @override
  Widget build(BuildContext context) {
    tz.initializeTimeZones();

    GlobalConstants.InitNotifications();
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
          BlocProvider(create: (context) => HistoryBloc()),
          BlocProvider(create: (context) => AlbaranBloc()),
          BlocProvider(create: (context) => CobrosBloc()),
          BlocProvider(create: (context) => AlertasBloc()),
          BlocProvider(create: (context) => PedidosDiaBloc())
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
            'alertas': (context) => AlertasScreen(),
            'pedidos_dia': (context) => PedidosDiaScreen(),
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
