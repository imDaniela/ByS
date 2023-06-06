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
}
