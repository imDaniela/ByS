import 'package:bys_app/general/customHttp.dart';
import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';

class HistoryApi {
  static Future<http.Response?> GetHistory(int codcli) async {
    try {
      http.Response result = await customHttpGet(
          Uri.parse(
              '${GlobalConstants.apiEndPoint}get-cliente-historial/${codcli}'),
          headers: GlobalConstants.header());
      return result;
    } catch (ex) {}
  }
}
