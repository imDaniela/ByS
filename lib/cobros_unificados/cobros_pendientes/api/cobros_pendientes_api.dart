import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';

class CobrosPendientesApi {

  static Future<http.Response> getCobros({
    DateTime? inicio,
    DateTime? fin,
    String? search,
  }) async {
    final init = (inicio ?? DateTime.now());
    final end = (inicio ?? DateTime.now());
    final initText = '${init.year}-${init.month}-${init.day}';
    final endText = '${end.year}-${end.month}-${end.day}';
    String url = '${kDebugMode ? fakeEndPoint : GlobalConstants.apiEndPoint}get-facturas-pendientes?fecha_inicio=$initText&fecha_fin=$endText&forma_pago=&search=${search??''}';
    final response = await http.get(Uri.parse(url), headers: GlobalConstants.header());
    return response;
  }

  static Future<http.Response> getDetalles({required int codigoCliente}) async {
    String url = '${kDebugMode ? fakeEndPoint : GlobalConstants.apiEndPoint}get-detalles-facturas-pendientes/$codigoCliente';
    final response = await http.get(Uri.parse(url), headers: GlobalConstants.header());
    return response;
  }

}