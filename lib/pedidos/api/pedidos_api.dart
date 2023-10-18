import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bys_app/general/customHttp.dart';
import 'package:bys_app/pedidos/models/PedidoLinea.dart';
import 'package:http/http.dart' as http;
import 'package:bys_app/general/const.dart';
import 'package:path_provider/path_provider.dart';

import 'package:uri_to_file/uri_to_file.dart';

class PedidosApi {
  static Future<http.Response> Saldo(int codcli) async {
    String url =
        '${GlobalConstants.apiEndPoint}get-cliente-saldo-pendiente/${codcli}';

    http.Response result =
        await customHttpGet(Uri.parse(url), headers: GlobalConstants.header());

    return result;
  }

  static Future<http.Response> gePedido(int codcli) async {
    String url = '${GlobalConstants.apiEndPoint}get-pedido/${codcli}';
    http.Response result =
        await customHttpGet(Uri.parse(url), headers: GlobalConstants.header());
    print(result.body);
    return result;
  }

  static Future<File> getPedidoPdf(int numped) async {
    String uriString =
        '${GlobalConstants.apiEndPoint}pdf-pedido/${numped}'; // Uri string
    final http.Response responseData = await http.get(Uri.parse(uriString));
    Uint8List list = responseData.bodyBytes;
    var buffer = list.buffer;
    ByteData byteData = ByteData.view(buffer);
    var tempDir = await getExternalStorageDirectory();
    File file = await File('${tempDir?.path}/pedido.pdf').writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }

  static Future<http.Response> SavePedido(int codcli, List<PedidoLinea> linea,
      {String observaciones = "", String intobs = ""}) async {
    String url = '${GlobalConstants.apiEndPoint}save-pedido';
    String _body = jsonEncode({
      'codcli': codcli,
      'lineas': linea,
      'observaciones': observaciones,
      'intobs': intobs
    });
    print(_body);
    http.Response result = await customHttpPost((url), body: _body);
    return result;
  }
}
