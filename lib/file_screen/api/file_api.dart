import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';

class FilesApi {
  static Future<http.Response> getArchivos() async {
    String url = '${GlobalConstants.apiEndPoint}get-archivos';
    final response =
        await http.get(Uri.parse(url), headers: GlobalConstants.header());
    return response;
  }
}
