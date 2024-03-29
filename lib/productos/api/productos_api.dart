import 'package:bys_app/general/customHttp.dart';
import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';

class ProductosApi {
  static Future<http.Response> getProductos(int codcli) async {
    String url = '${GlobalConstants.apiEndPoint}get-articulos/${codcli}';

    http.Response result =
        await customHttpGet(Uri.parse(url), headers: GlobalConstants.header());

    return result;
  }
}
