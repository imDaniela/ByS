import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';

class ProductosApi {
  static Future<http.Response> getProductos() async {
    String url = '${GlobalConstants.apiEndPoint}get-articulos';

    http.Response result =
        await http.get(Uri.parse(url), headers: GlobalConstants.header());

    return result;
  }
}
