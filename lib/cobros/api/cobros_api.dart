import 'dart:convert';

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
    http.Response result = await http.post(Uri.parse(url),
        headers: GlobalConstants.header(), body: _body);
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
    http.Response result = await http.post(Uri.parse(url),
        headers: GlobalConstants.header(), body: _body);
    return result;
  }
}
