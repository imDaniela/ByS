import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';

class AlbaranApi {
  static Future<http.Response?> GetAlbaranes(int codcli) async {
    try {
      http.Response result = await http.get(
          Uri.parse(
              '${GlobalConstants.apiEndPoint}get-albaranes-facturas-pendientes/${codcli}'),
          headers: GlobalConstants.header());
      return result;
    } catch (ex) {}
  }
}
