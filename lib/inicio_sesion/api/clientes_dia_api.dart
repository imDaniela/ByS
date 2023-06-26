import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';

class ClientesDiaApi {
  static Future<http.Response?> GetClientesDia(int dia) async {
    print(GlobalConstants.header());

    print('${GlobalConstants.apiEndPoint}get-clientes-dia/${dia}');
    try {
      http.Response result = await http.get(
          Uri.parse('${GlobalConstants.apiEndPoint}get-clientes-dia/${dia}'),
          headers: GlobalConstants.header());

      return result;
    } catch (ex) {
      print(ex);
    }
    return null;
  }

  static Future<http.Response?> SearchClientes(String search) async {
    print(GlobalConstants.header());

    print('${GlobalConstants.apiEndPoint}search-clientes/${search}');
    try {
      http.Response result = await http.get(
          Uri.parse('${GlobalConstants.apiEndPoint}search-clientes/${search}'),
          headers: GlobalConstants.header());

      return result;
    } catch (ex) {
      print(ex);
    }
    return null;
  }
}
