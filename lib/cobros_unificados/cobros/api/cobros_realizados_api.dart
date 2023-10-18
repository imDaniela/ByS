import 'package:bys_app/general/customHttp.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';

class CobrosRealizadosApi {
  static Future<http.Response> getCobros(
      {DateTime? inicio,
      DateTime? fin,
      String? search,
      required String metodo}) async {
    final init = (inicio ?? DateTime.now());
    final end = (fin ?? DateTime.now());
    final initText = '${init.year}-${init.month}-${init.day}';
    final endText = '${end.year}-${end.month}-${end.day}';
    String url =
        '${GlobalConstants.apiEndPoint}get-cobros?fecha_inicio=$initText&fecha_fin=$endText&forma_pago=${metodo}&search=${search ?? ''}';
    final response =
        await customHttpGet(Uri.parse(url), headers: GlobalConstants.header());
    return response;
  }

  static Future<http.Response> getDetalles(
      {DateTime? inicio,
      DateTime? fin,
      required int numeroFactura,
      required String metodo}) async {
    final init = (inicio ?? DateTime.now());
    final end = (fin ?? DateTime.now());
    final initText = '${init.year}-${init.month}-${init.day}';
    final endText = '${end.year}-${end.month}-${end.day}';
    String url =
        '${GlobalConstants.apiEndPoint}get-detalles-cobro/$numeroFactura?fecha_inicio=$initText&fecha_fin=$endText&forma_pago=$metodo';
    final response =
        await customHttpGet(Uri.parse(url), headers: GlobalConstants.header());
    return response;
  }
}
