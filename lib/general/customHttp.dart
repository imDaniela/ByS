import 'package:bys_app/general/const.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<http.Response> customHttpGet(Uri url,
    {Map<String, String>? headers}) async {
  final response = await http.get(url, headers: GlobalConstants.header());

  if (response.statusCode == 503) {
    GlobalConstants.scaffoldState.currentState?.showSnackBar(
      SnackBar(content: Text('El servidor esta en mantenimiento.')),
    );
  }
  // ... handle other status codes or errors if needed ...

  return response;
}

Future<http.Response> customHttpPost(
  String url, {
  required String body,
}) async {
  final response = await http.post(
    Uri.parse(url),
    headers: GlobalConstants.header(),
    body: body,
  );

  if (response.statusCode == 503) {
    GlobalConstants.scaffoldState.currentState?.showSnackBar(
      SnackBar(content: Text('El servidor esta en mantenimiento.')),
    );
  }
  // ... handle other status codes or errors if needed ...

  return response;
}
