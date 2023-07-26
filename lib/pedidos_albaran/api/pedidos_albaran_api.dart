import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';

class PedidosAlbaranApi {
  static Future<http.Response> searchPedido(String? query) async {
    String url =
        '${GlobalConstants.apiEndPoint}get-pedido-albaran?search=${query ?? ''}';
    final response =
        await http.get(Uri.parse(url), headers: GlobalConstants.header());
    return response;
  }

  static Future<http.Response> getPedido(int codigo) async {
    String url = '${GlobalConstants.apiEndPoint}get-pedido-albaran/$codigo}';
    final response =
        await http.get(Uri.parse(url), headers: GlobalConstants.header());
    return response;
  }
}
