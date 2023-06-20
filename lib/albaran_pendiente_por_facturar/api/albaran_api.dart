import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';

class AlbaranApi {
  static Future<http.Response?> GetAlbaranes(int codcli) async {
    print(GlobalConstants.header());

    print(
        '${GlobalConstants.apiEndPoint}get-albaranes-facturas-pendientes/${codcli}');
    try {
      http.Response result = await http.get(
          Uri.parse(
              '${GlobalConstants.apiEndPoint}get-albaranes-facturas-pendientes/${codcli}'),
          headers: GlobalConstants.header());
      print(result.body);
      return result;
    } catch (ex) {
      print(ex);
    }
  }
}
