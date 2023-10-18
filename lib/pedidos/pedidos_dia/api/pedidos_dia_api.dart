import 'package:bys_app/general/customHttp.dart';
import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';

class PedidosDiaApi {
  static Future<http.Response> getProductos({DateTime? dia}) async {
    DateTime aja = dia ??= DateTime.now();
    String url =
        '${GlobalConstants.apiEndPoint}get-pedidos-dia/${aja.toIso8601String()}';
    print(url);
    http.Response result =
        await customHttpGet(Uri.parse(url), headers: GlobalConstants.header());
    return result;
  }
}
