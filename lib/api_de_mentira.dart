import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

class ApiDeMentira {

  startServer() async {
    var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
    if (kDebugMode) {
      print("Server running on IP : ${server.address} On Port : ${server.port}");
    }
    await for (var request in server) {
      if (request.uri.toString().contains('get-pedido-albaran?search=')) {
        await Future.delayed(const Duration(seconds: 3));
        final reply = jsonEncode([
          {
            "NUMALB":3441,
            "FECGAR":"2020-02-26T00:00:00.000Z",
            "IDMOVISTAR":0,
            "cliente":{
              "CODCLI":3,
              "nom":"HEINEKEN ESPAÑA, S.A. ",
              "cal2":"”asdasdasdasdasd”"
            }
          },
          {
            "NUMALB":3451,
            "FECGAR":"2022-02-26T00:00:00.000Z",
            "IDMOVISTAR":56,
            "cliente":{
              "CODCLI":2,
              "nom":"NENEENE ESPAÑA, S.A. ",
              "cal2":"PAPITA FRITA"
            }
          },
        ]);
        request.response
          ..statusCode = HttpStatus.ok
          ..write(reply)
          ..close();
      } else if (request.uri.toString().contains('get-pedido-albaran')) {
        await Future.delayed(const Duration(seconds: 3));
        final reply = jsonEncode([
          {
            "NUMALB":3441,
            "CODART":"1153 ",
            "FECGAR":"2020-02-26T00:00:00.000Z",
            "CANSER":2,
            "PREVEN":152.01,
            "SUBTOT":304.02
          },
          {
            "NUMALB":3441,
            "CODART":"0130 ",
            "FECGAR":"2020-02-26T00:00:00.000Z",
            "CANSER":2,
            "PREVEN":30,
            "SUBTOT":60
          }
        ]);
        request.response
          ..statusCode = HttpStatus.ok
          ..write(reply)
          ..close();
      }
    }
  }

}