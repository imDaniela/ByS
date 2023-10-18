import 'dart:convert';

import 'package:bys_app/general/customHttp.dart';
import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';

class CobrosApi {
  static Future<http.Response> saveCobro(
      {required int codcli,
      required String forma_pago,
      required int numfac,
      required double cobro,
      required DateTime fecha}) async {
    String url = '${GlobalConstants.apiEndPoint}save-cobro';
    String _body = jsonEncode({
      'codclie': codcli,
      'forma_pago': forma_pago,
      'numfac': numfac,
      'cobro': cobro,
      'fecha': fecha.toString()
    });
    http.Response result = await customHttpPost(url, body: _body);
    return result;
  }

  static Future<http.Response> deleteCobro({
    required int codcli,
    required int numfac,
  }) async {
    String url = '${GlobalConstants.apiEndPoint}delete-cobro';
    String _body = jsonEncode({
      'codclie': codcli,
      'numfac': numfac,
    });
    http.Response result = await customHttpPost(url, body: _body);
    return result;
  }

  static Future<http.Response> getCobros(
      {DateTime? inicio,
      DateTime? fin,
      String? search,
      required String forma_pago}) async {
    final init = (inicio ?? DateTime.now());
    final end = (inicio ?? DateTime.now());
    final initText = '${init.year}-${init.month}-${init.day}';
    final endText = '${end.year}-${end.month}-${end.day}';
    String url =
        '${GlobalConstants.apiEndPoint}get-cobros?fecha_inicio=$initText&fecha_fin=$endText&forma_pago=${forma_pago}&search=${search ?? ''}';
    print(url);
    final response =
        await customHttpGet(Uri.parse(url), headers: GlobalConstants.header());
    return response;
  }

  static Future<http.Response> getDetalles({required int numeroFactura}) async {
    String url =
        '${GlobalConstants.apiEndPoint}get-detalles-cobro/$numeroFactura';
    final response =
        await customHttpGet(Uri.parse(url), headers: GlobalConstants.header());
    return response;
  }
}
