import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';

class HistoryApi {
  static Future<http.Response?> GetHistory(int codcli) async {
    print(GlobalConstants.header());

    print('${GlobalConstants.apiEndPoint}get-cliente-historial/${codcli}');
    try {
      http.Response result = await http.get(
          Uri.parse(
              '${GlobalConstants.apiEndPoint}get-cliente-historial/${codcli}'),
          headers: GlobalConstants.header());
      print(result.body);
      return result;
    } catch (ex) {
      print(ex);
    }
  }
}
