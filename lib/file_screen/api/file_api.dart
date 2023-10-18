import 'dart:convert';

import 'package:bys_app/file_screen/modelo/Archivo.dart';
import 'package:bys_app/general/customHttp.dart';
import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';
import 'package:image_picker/image_picker.dart';

class FilesApi {
  static Future<http.Response> getArchivos(String tipo) async {
    String url = '${GlobalConstants.apiEndPoint}get-archivos/${tipo}';
    final response =
        await customHttpGet(Uri.parse(url), headers: GlobalConstants.header());
    return response;
  }

  static Future<http.Response> deleteArchivoFromUrl(Archivo archivo) async {
    String url = archivo.url.replaceAll('get-archivo', 'delete-archivo');
    print(url);
    final response =
        await customHttpGet(Uri.parse(url), headers: GlobalConstants.header());
    return response;
  }

  static Future<http.Response> deleteArchivo(
      String codrep, String tipo, String filename) async {
    String url =
        '${GlobalConstants.apiEndPoint}delete-archivo/${codrep}/${tipo}/${filename}';
    final response =
        await customHttpGet(Uri.parse(url), headers: GlobalConstants.header());
    return response;
  }

  static Future<http.Response> saveArchivo(
      int codrep, String tipo, XFile file) async {
    print('guardando');
    final List<int> imageBytes = await file.readAsBytes();
    final String base64Image = base64Encode(imageBytes);
    String body = jsonEncode({
      "ext": file.name.split('.')[1],
      "codrep": codrep != -1 ? codrep.toString() : 'todos',
      "tipo": tipo,
      "file": base64Image
    });
    String url =
        '${GlobalConstants.apiEndPoint}save-file/${tipo}/${file.name.split('.')[1]}';
    final response = await customHttpPost(url, body: body);
    print(response.body);
    return response;
  }

  static Future<http.Response> getArchivosTodos(String tipo) async {
    String url = '${GlobalConstants.apiEndPoint}get-archivos/${tipo}/todos';
    final response =
        await customHttpGet(Uri.parse(url), headers: GlobalConstants.header());
    return response;
  }
}
