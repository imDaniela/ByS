import 'dart:convert';

import 'package:bys_app/general/customHttp.dart';
import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';

class AlertasApi {
  static Future<http.Response> saveAlerta(
      {int? id,
      required int codcli,
      required String descripcion,
      required DateTime fecha}) async {
    String url = '${GlobalConstants.apiEndPoint}save-alerta';
    Map<String, String> _body_str = {
      'id_cliente': codcli.toString(),
      'fecha': fecha.toIso8601String(),
      'comentario': descripcion,
    };
    if (id != null) {
      _body_str.addAll({'id': id.toString()});
    }
    String _body = jsonEncode(_body_str);
    print(id);
    http.Response result = await customHttpPost(url, body: _body);
    return result;
  }

  static Future<http.Response> getAlertas() async {
    String url = '${GlobalConstants.apiEndPoint}get-alertas';

    http.Response result =
        await customHttpGet(Uri.parse(url), headers: GlobalConstants.header());
    return result;
  }

  static Future<http.Response> deleteAlerta({
    required int id,
  }) async {
    String url = '${GlobalConstants.apiEndPoint}delete-alerta/$id';

    http.Response result =
        await customHttpGet(Uri.parse(url), headers: GlobalConstants.header());
    return result;
  }
}
