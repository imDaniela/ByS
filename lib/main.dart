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
import 'package:installed_apps/app_info.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //vpn
  late OpenVPN engine;

  VpnStatus? status;
  VPNStage? stage;
  bool _granted = false;
  void initialize() {
    engine = OpenVPN(
      onVpnStatusChanged: (data) {
        setState(() {
          status = data;
        });
      },
      onVpnStageChanged: (data, raw) {
        setState(() {
          stage = data;
        });
      },
    );

    engine.initialize(
      groupIdentifier: "group.com.bys.vpn",
      providerBundleIdentifier: "id.fidias.bys_app.VPNExtension",
      localizedDescription: "VPN BYS",
      lastStage: (stage) {
        print(stage.name);
        setState(() {
          this.stage = stage;
        });
      },
      lastStatus: (status) {
        print(status.duration);
        setState(() {
          this.status = status;
        });
      },
    );
    initPlatformState();
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future<void> initPlatformState() async {
    List<AppInfo> apps = await InstalledApps.getInstalledApps(false, false, "");
    List<String> bypass = [];
    apps.forEach((element) {
      print(element.packageName);
      if (element.packageName != 'com.example.bys_app')
        bypass.add(element.packageName ?? '');
    });
    print(config);
    engine.connect(config, "BYS",
        username: defaultVpnUsername,
        password: defaultVpnPassword,
        certIsRequired: true,
        bypassPackages: bypass);
    if (!mounted) return;
  }

  //finvps
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

const String defaultVpnUsername = "Jonathan";
const String defaultVpnPassword = "jonathan";

String config = '''##############################################
# Sample client-side OpenVPN 2.0 config file #
# for connecting to multi-client server.     #
#                                            #
# This configuration can be used by multiple #
# clients, however each client should have   #
# its own cert and key files.                #
#                                            #
# On Windows, you might want to rename this  #
# file so it has a .ovpn extension           #
##############################################

# Specify that we are a client and that we
# will be pulling certain config file directives
# from the server.
client

# Use the same setting as you are using on
# the server.
# On most systems, the VPN will not function
# unless you partially or fully disable
# the firewall for the TUN/TAP interface.
;dev tap
dev tun

# Windows needs the TAP-Win32 adapter name
# from the Network Connections panel
# if you have more than one.  On XP SP2,
# you may need to disable the firewall
# for the TAP adapter.
;dev-node MyTap

# Are we connecting to a TCP or
# UDP server?  Use the same setting as
# on the server.
proto tcp
;proto udp

# The hostname/IP and port of the server.
# You can have multiple remote entries
# to load balance between the servers.
# remote 78.136.126.220 1194
remote 90.71.46.4 1194

#remote 185.225.246.195 1194
;remote my-server-2 1194

# Choose a random host from the remote
# list for load-balancing.  Otherwise
# try hosts in the order specified.
;remote-random

# Keep trying indefinitely to resolve the
# host name of the OpenVPN server.  Very useful
# on machines which are not permanently connected
# to the internet such as laptops.
resolv-retry infinite

# Most clients don't need to bind to
# a specific local port number.
nobind

# Downgrade privileges after initialization (non-Windows only)
;user nobody
;group nobody

# Try to preserve some state across restarts.
persist-key
persist-tun

# If you are connecting through an
# HTTP proxy to reach the actual OpenVPN
# server, put the proxy server/IP and
# port number here.  See the man page
# if your proxy server requires
# authentication.
;http-proxy-retry # retry on connection failures
;http-proxy [proxy server] [proxy port #]

# Wireless networks often produce a lot
# of duplicate packets.  Set this flag
# to silence duplicate packet warnings.
;mute-replay-warnings

# SSL/TLS parms.
# See the server config file for more
# description.  It's best to use
# a separate .crt/.key file pair
# for each client.  A single ca
# file can be used for all clients.
# ca cert_export_ca-certificate.crt
# cert cert_export_bys-client-certificate.crt
# key cert_export_bys-client-certificate.key

# Verify server certificate by checking that the
# certicate has the correct key usage set.
# This is an important precaution to protect against
# a potential attack discussed here:
#  http://openvpn.net/howto.html#mitm
#
# To use this feature, you will need to generate
# your server certificates with the keyUsage set to
#   digitalSignature, keyEncipherment
# and the extendedKeyUsage to
#   serverAuth
# EasyRSA can do this for you.
remote-cert-tls server

# If a tls-auth key is used on the server
# then every client must also have the key.
;tls-auth ta.key 1

# Select a cryptographic cipher.
# If the cipher option is used on the server
# then you must also specify it here.
# Note that v2.4 client/server will automatically
# negotiate AES-256-GCM in TLS mode.
# See also the ncp-cipher option in the manpage
cipher AES-128-CBC
data-ciphers 'AES-128-CBC'
data-ciphers-fallback 'AES-128-CBC'


auth SHA1
auth-user-pass
;route 192.168.99.0 255.255.255.0 192.168.97.10
redirect-gateway def1

# Enable compression on the VPN link.
# Don't enable this unless it is also
# enabled in the server config file.
#comp-lzo

# Set log file verbosity.
verb 3

# Silence repeating messages
;mute 20
<ca>
-----BEGIN CERTIFICATE-----
MIIDDjCCAfagAwIBAgIIamtU0r/w5T4wDQYJKoZIhvcNAQELBQAwEjEQMA4GA1UE
AwwHYnlzLmNvbTAeFw0xODA2MjgyMzIwMTVaFw0yODA2MjUyMzIwMTVaMBIxEDAO
BgNVBAMMB2J5cy5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDJ
mrQDqldBNE+SnpW2EoWxxiIo+HpLXFbqf/anhdzaMom0uVMmEIMQwSxu9Zajiey0
A4l1B4Cr+ncsEMGxyVB6YEJGrFHkuat62txcyNtSbtwbhQGhuB9nqHiFgzSo7hYs
qufvF6q9drY6faekZcRu83OVxBjG2zjx7AOOfhg9lGKUYVongQurTy+zxPLvPTku
1DSBWMR++5WPTtiaum+YwHrybFndK0mHnj32rPojRrCQMtnH0J0mDP7ntG25fa5F
D0VU95s75AWpzTMvrzdpDMnNcRHQS+fyeUdjitvSoi9D6M0ByTjbR0kxCeFT1qN+
xg51byDirnKKKZqeJ3HlAgMBAAGjaDBmMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0P
AQH/BAQDAgEGMB0GA1UdDgQWBBRVpQNqo52acL4hqMoRh+KSGcGE3DAkBglghkgB
hvhCAQ0EFxYVR2VuZXJhdGVkIGJ5IFJvdXRlck9TMA0GCSqGSIb3DQEBCwUAA4IB
AQBUsZjnQ+lu6AnvEbt4OABQMWlrwz8H7wd7/Dn5NIQRokU4TZ2I7dE/2Yao7Vee
I7lABEeuxHFUOxsgCtpyD/YnfnuGgxxa+ZWHlSObyYUGgT28MvVIY1NcRjkaMg0j
tnHGOo3ANuv2pDF4e94Fta/EtvgQWSgwAgjrO50ANELY+7tDL5S7aZw3m1F7PTt/
hV5uiJpxXXAu4noRdF2YfpykT7kw7vIF6owmo22Yg2BH66cOJCK8nLDY+g8vSg2n
r3XxNYov1Hwm8qpmdsiMHwyJOIoQ+Ub7cpNh9odfU0IBNffBsW7Dj5xJ2Z5T+Z7a
9FngzCLlcuTEpTBpNM4sKbza
-----END CERTIFICATE-----
</ca>
<cert>
-----BEGIN CERTIFICATE-----
MIIDKjCCAhKgAwIBAgIIWMvRvXE6VNwwDQYJKoZIhvcNAQELBQAwEjEQMA4GA1UE
AwwHYnlzLmNvbTAeFw0xODA2MjgyMzIwNTRaFw0yODA2MjUyMzIwNTRaMBkxFzAV
BgNVBAMMDmNsaWVudC5ieXMuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAwc+dqejX+Hl8MFKlUqBmYMLYPJVRO7KFwLNs9Bskzzyka2N/zxz+S8HQ
+eT3u7hIhHLbkOg1FTmUTNE2fegeeSYpV9kUT9OoMMafrJIk4cpetJVUrQWMqrsu
DSifr0h56II27cyAAAyUE9ktK7v7cixQIIzxhJMRAVwj41ziQHRemyQQQTVs+PAI
iNGPdZfr8aX4GaHZhXsTueCaDFc6H54vBratmPWclAgtC/oy0Gv5J2aECTDi6hgd
BYGAhR5VSpa3mFKL9zf7JnWwmVk0zu/DDriQNkeL2sVL4iK9E4xFzzgn30DuvW5s
ZWJiMCch8sOOFrHV0FeeN8GGgYZcIQIDAQABo30wezATBgNVHSUEDDAKBggrBgEF
BQcDAjAdBgNVHQ4EFgQUU0lsPr8dP2FJotAP8+NCP0F49YAwHwYDVR0jBBgwFoAU
VaUDaqOdmnC+IajKEYfikhnBhNwwJAYJYIZIAYb4QgENBBcWFUdlbmVyYXRlZCBi
eSBSb3V0ZXJPUzANBgkqhkiG9w0BAQsFAAOCAQEAcv1jWamFhb7Ephu8MTKEvJbe
QZwy66Q7WyqcHVlFxKTHT/ya7gP6wO90gYIUG9BvEKK99WC3awyfQ8wnAHZP8TH+
erh4pRayIxfEkEbudc/jnjoLngSZOxTs/l9YZhm7iKb+p1NVk86XR7uzwYFE52ia
cPHhyZ3lKzHKk5+YGB8gPxnq7l5KFJTlFV4ItTrQJIe0KZikvb8uJsTcQyhAwga+
shGRaOxVyRjX6vL4XbCHfV4YhV+wh4y4CicDMCoTXMq0/YpVLS0aoeZg6QBQ1ZDh
6bxz0/SCeBp6kkNS2X5bD79uE67pVeHWpGz1Jwo0uP2+JJxsnEgW25sg7wQNVA==
-----END CERTIFICATE-----
</cert>
<key>
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAwc+dqejX+Hl8MFKlUqBmYMLYPJVRO7KFwLNs9Bskzzyka2N/
zxz+S8HQ+eT3u7hIhHLbkOg1FTmUTNE2fegeeSYpV9kUT9OoMMafrJIk4cpetJVU
rQWMqrsuDSifr0h56II27cyAAAyUE9ktK7v7cixQIIzxhJMRAVwj41ziQHRemyQQ
QTVs+PAIiNGPdZfr8aX4GaHZhXsTueCaDFc6H54vBratmPWclAgtC/oy0Gv5J2aE
CTDi6hgdBYGAhR5VSpa3mFKL9zf7JnWwmVk0zu/DDriQNkeL2sVL4iK9E4xFzzgn
30DuvW5sZWJiMCch8sOOFrHV0FeeN8GGgYZcIQIDAQABAoIBAHeNA+pNMPuapJqC
QGyJeN1zE0O7r5Itewf1Jd4l6DzVYW7Ev5AYiFxev/OF47Kt6D2bRAlM04G2NN51
pzFfP3znp1UDGN5s5zC/NLuUop+M34JxIvxfkfe24p9HUckj4d8kg5GINeTR3X2o
145EtMQmxX5usoRe23yFQ7X6E65BhqE4LK12OOTmVhJXgTRoyrvQeUNqM87Qjru0
JxAiywc3001IpJjvY85D6ehaCMwjMsA2p3HxTV06cIj60GCYq5/RewLqBikEvFFi
/g5xRsRllBPKdNuUZxjSSo5q5vBLHPckMu2U4IYv8JQHTCvNTlT5QDw+zsNwkHM1
T4olQ+ECgYEA7zz1Y1iAy4jH3i30din8zcQfVQ8y0FWgYSsWOQ+fu1d9d0Yzzj5C
j6VFuj9vOZccOSDxG1YipHkqKiPnrKMuMi2y86NYzxEATweKo0pvEiYaRUPM/lYn
rYFketADLNqevgv/K0Qt60XVXQingxB2/WGH8ebgJCUrFFBkVEarO30CgYEAz2Pd
JpXICAS5PPsktdL1Qs0v+a77eLwePlDQhD66cFfsEMscveIQc3i8MNZfEadfFPlQ
5cn8yHmRfrH1dr893JCnkBp7qZqM5m4hU1ZXL+JLG/vkj9lNe+h4+RaL/laGoYWW
NtdjBLbbchmEWNQeXdMU2OGXvqYZendn6zhUnHUCgYEAktAb3r1/PGhSDzywWptl
snh6qd5L1qHVbAve9WFrKrKEImAIhraabkCES8mF3henkD9w9s+jLr/UakviboUt
Ykm9GdrSMzBBuj3sjEyvYLnVQVBcSnBgpQ9UtDFW4X3AEOyXyNtsOod+ajtXYQ0H
mHLz1DVUs5nDmBHFoBpGFpkCgYEAvTxKVyLk2yw0OkiPPrm3wbSoyhO4sno0vnfP
TFxQkqInbUtodnsIt9S7I3T4Wot2XxT/lC2y0trav9hyOmBWeiQkQYFoxWGYn8pt
7jUiaTb7ghVegUOvSBjgCalhJDqfrlLOtkvitjKEGqDd+o/TBZnNs/hlFjlJlk3O
LPvBeOECgYBo+OlFYd6U2f/ppR0JRFgR2PNJec3JsCJ3asT/jzCxhUjtn1fE3hM9
8b/BLmufK7bfxgC0WKITyiuh5il2VNMgooNc3QTmmG1kefVBVXYCqNhsTkn7rCXu
EtKsRUf4AdcFC7s/S++8Cf1DyEjTez79WNT4bPBv/kve3dlE2PMZfQ==
-----END RSA PRIVATE KEY-----
</key>
''';
