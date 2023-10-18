import 'dart:convert';

import 'package:bys_app/general/customHttp.dart';
import 'package:bys_app/inicio_sesion/model/ClientesDia.dart';
import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';

class ClientesDiaApi {
  static Future<http.Response?> GetClientesDia(int dia) async {
    try {
      http.Response result = await customHttpGet(
          Uri.parse('${GlobalConstants.apiEndPoint}get-clientes-dia/${dia}'),
          headers: GlobalConstants.header());

      return result;
    } catch (ex) {}
    return null;
  }

  static Future<http.Response> deleteClienteDia(ClientesDia cliente) async {
    print('agregando cliente');
    http.Response result = await customHttpPost(
      '${GlobalConstants.apiEndPoint}delete-cliente-dia',
      body: jsonEncode({
        'codcli': cliente.codcli,
        'dia': cliente.Ordgeo2,
        'tarde': cliente.Ordgeo1,
      }),
    );
    print(result.body);
    return result;
  }

  static Future<http.Response> addClienteDia(
      int codcli, int dia, int tarde) async {
    print('agregando cliente');
    http.Response result = await customHttpPost(
      '${GlobalConstants.apiEndPoint}add-cliente-dia',
      body: jsonEncode({
        'codcli': codcli,
        'dia': dia,
        'tarde': tarde,
      }),
    );
    print(result.body);
    return result;
  }

  static Future<http.Response> getAllClientes() async {
    http.Response result = await customHttpGet(
        Uri.parse('${GlobalConstants.apiEndPoint}get-clientes'),
        headers: GlobalConstants.header());

    return result;
  }

  static Future<http.Response?> SearchClientes(String search) async {
    try {
      http.Response result = await customHttpGet(
          Uri.parse('${GlobalConstants.apiEndPoint}search-clientes/${search}'),
          headers: GlobalConstants.header());

      return result;
    } catch (ex) {}
    return null;
  }
}
