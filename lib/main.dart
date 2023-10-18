import 'package:bys_app/albaran_pendiente_por_facturar/bloc/albaran_bloc.dart';
import 'package:bys_app/alertas/alertas_screen.dart';
import 'package:bys_app/alertas/bloc/alertas_bloc.dart';
import 'package:bys_app/api_de_mentira.dart';
import 'package:bys_app/clientes_del_dia/historial_cliente/bloc/history_bloc.dart';
import 'package:bys_app/clientes_del_dia/list_screen.dart';
import 'package:bys_app/clientes_del_dia/client_screen.dart';
import 'package:bys_app/cobros/bloc/cobros_bloc.dart';
import 'package:bys_app/cobros/cobros_screen.dart';
import 'package:bys_app/cobros_unificados/cobros/bloc/cobros_realizados_bloc.dart';
import 'package:bys_app/cobros_unificados/cobros_pendientes/bloc/cobros_pedientes_bloc.dart';
import 'package:bys_app/cobros_unificados/cobros_unificados.dart';
import 'package:bys_app/componentes_comunes/navigation_bar.dart';
import 'package:bys_app/file_screen/bloc/file_bloc.dart';
import 'package:bys_app/file_screen/file_screen.dart';
import 'package:bys_app/file_screen/file_selector.dart';
import 'package:bys_app/general/const.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesbloc/clientes_bloc.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:bys_app/inicio_sesion/bloc/login_bloc.dart';
import 'package:bys_app/pedidos/bloc/pedidos_bloc.dart';
import 'package:bys_app/pedidos/pedidos.dart';
import 'package:bys_app/pedidos/pedidos_dia/bloc/pedidos_dia_bloc.dart';
import 'package:bys_app/pedidos/pedidos_dia/pedidos_screen.dart';
import 'package:bys_app/pedidos/zonacliente.dart';
import 'package:bys_app/pedidos_albaran/bloc/pedidos_albaran_bloc.dart';
import 'package:bys_app/pedidos_albaran/pedidosAlbaran.dart';
import 'package:bys_app/productos/bloc/productos_bloc.dart';
import 'package:bys_app/profile/profile_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bys_app/inicio_sesion/screen/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String title = 'ByS';

  @override
  Widget build(BuildContext context) {
    tz.initializeTimeZones();
    if (kDebugMode) {
      //ApiDeMentira().startServer();
    }

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
          BlocProvider(create: (context) => PedidosAlbaranBloc()),
          BlocProvider(create: (context) => ProductosBloc()),
          BlocProvider(create: (context) => HistoryBloc()),
          BlocProvider(create: (context) => AlbaranBloc()),
          BlocProvider(create: (context) => CobrosBloc()),
          BlocProvider(create: (context) => CobrosRealizadosBloc()),
          BlocProvider(create: (context) => AlertasBloc()),
          BlocProvider(create: (context) => PedidosDiaBloc()),
          BlocProvider(create: (context) => CobrosPendientesBloc()),
          BlocProvider(create: (context) => FileBloc()),
          BlocProvider(
              create: (context) => ClientesBloc()..add(LoadAllClientes()))
        ],
        child: MaterialApp(
            title: title,
            theme: theme,
            navigatorKey: GlobalConstants.navState,
            scaffoldMessengerKey: GlobalConstants.scaffoldState,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en'), // English
              Locale('es'), // Spanish
            ],
            routes: {
              'login': (context) => const LoginScreen(),
              'dias': (context) => const DayScreen(),
              'client': (context) => const ClientScreen(),
              'pedidos': (context) => const PedidosScreen(),
              'pedidos_albaran': (context) => const PedidosAlbaranScreen(),
              'cobros': (context) => const CobrosScreen(),
              'zona_clientes': (context) => const ZonaCliente(),
              'alertas': (context) => const AlertasScreen(),
              'pedidos_dia': (context) => const PedidosDiaScreen(),
              'root_home': (context) => RootHome(),
              'file_screen': (context) => FileSelector()
            },
            home: LoginScreen() //const LoginScreen() // LoginScreen()
            ));
  }
}

class RootHome extends StatefulWidget {
  const RootHome({Key? key}) : super(key: key);

  @override
  State<RootHome> createState() => _RootHomeState();
}

class _RootHomeState extends State<RootHome> {
  // Pages current index
  int currentIndex = 0;

  // Current Screens (3)
  static List<Widget> screens = const [
    DayScreen(key: GlobalObjectKey('dayScreen')),
    PedidosAlbaranScreen(key: GlobalObjectKey('pedidosAlb')),
    CobrosUnificados(key: GlobalObjectKey('cobros')),
    FileSelector(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     title: const Text(title),
      //     backgroundColor: const Color.fromRGBO(
      //         142, 11, 44, 1)), // Set the background color of the AppBar
      body: currentScreen(),
      bottomNavigationBar: AppNavigationBar(
          currentIndex: currentIndex,
          onChange: (index) => setState(() => currentIndex = index)),
    );
  }

  Widget currentScreen() {
    return screens[currentIndex];
  }
}
