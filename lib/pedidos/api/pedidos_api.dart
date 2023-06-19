import 'dart:convert';

import 'package:bys_app/pedidos/models/PedidoLinea.dart';
import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';

class PedidosApi {
  static Future<http.Response> Saldo(int codcli) async {
    String url =
        '${GlobalConstants.apiEndPoint}get-cliente-saldo-pendiente/${codcli}';
    print(url);
    http.Response result =
        await http.get(Uri.parse(url), headers: GlobalConstants.header());
    print(result.body);
    return result;
  }

  static Future<http.Response> SavePedido(
      int codcli, List<PedidoLinea> linea) async {
    String url = '${GlobalConstants.apiEndPoint}save-pedido';
    print(url);
    http.Response result = await http.post(Uri.parse(url),
        headers: GlobalConstants.header(),
        body: jsonEncode({'codcli': codcli, 'lineas': linea}));
    print(result.body);
    return result;
  }
}
