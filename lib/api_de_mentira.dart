import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

class ApiDeMentira {

  int apiDelay = 1;

  startServer() async {
    var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
    if (kDebugMode) {
      print("Server running on IP : ${server.address} On Port : ${server.port}");
    }
    await for (var request in server) {
      if (request.uri.toString().contains('get-pedido-albaran?search=')) {
        await Future.delayed(Duration(seconds: apiDelay));
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
        await Future.delayed(Duration(seconds: apiDelay));
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
      } else if (request.uri.toString().contains('get-cobros?fecha_inicio')) {
        await Future.delayed(Duration(seconds: apiDelay));
        final reply = jsonEncode([
          {
            "CAN": "B ",
            "EJEFAC": 20,
            "NUMFAC": 3415,
            "FORPAG": " ",
            "CODCLI": 12059,
            "nom": "FRANCISCO JOSE GALVEZ JIMENEZ ",
            "cal2": "Cervecería D SAS 3 ",
            "importe": 134.38,
            "FECREM": "2023-06-19T00:00:00.000Z"
          },
          {
            "CAN": "B ",
            "EJEFAC": 20,
            "NUMFAC": 3413,
            "FORPAG": " ",
            "CODCLI": 12056,
            "nom": "FRANCISCO JOSE GALVEZ JIMENEZ ",
            "cal2": "Panaderia D SAS 3 ",
            "importe": 1344.38,
            "FECREM": "2023-06-19T00:00:00.000Z"
          },
        ]);
        request.response
          ..statusCode = HttpStatus.ok
          ..write(reply)
          ..close();
      } else if (request.uri.toString().contains('get-detalles-cobro')) {
        await Future.delayed(Duration(seconds: apiDelay));
        final reply = jsonEncode([
          {
            "CAN": "B ",
            "EJEFAC": 20,
            "NUMFAC": 3415,
            "CODCLI": 12059,
            "nom": "FRANCISCO JOSE GALVEZ JIMENEZ ",
            "cal2": "Cervecería D SAS 3 ",
            "IMPCOB": 134.38,
            "TS": "2023-06-20T00:00:00.000Z"
          },
          {
            "CAN": "B ",
            "EJEFAC": 20,
            "NUMFAC": 3445,
            "CODCLI": 12053,
            "nom": "FRANCISCO JOSE GALVEZ JIMENEZ ",
            "cal2": "Panaderia D SAS 3 ",
            "IMPCOB": 134.38,
            "TS": "2023-06-20T00:00:00.000Z"
          },
        ]);
        request.response
          ..statusCode = HttpStatus.ok
          ..write(reply)
          ..close();
      } else if (request.uri.toString().contains('get-facturas-pendientes')) {
        await Future.delayed(Duration(seconds: apiDelay));
        final reply = jsonEncode([
          {
            "CODCLI": 1196,
            "tfactura": 4146.33,
            "cliente": {
              "CODCLI": 1196,
              "nom": "HELENA PAOLO S.L. ",
              "cal2": "Sport Complex - RESTAURANTE "
            }
          },
          {
            "CODCLI": 1194,
            "tfactura": 600.33,
            "cliente": {
              "CODCLI": 1194,
              "nom": "PAUL PAOLO S.L. ",
              "cal2": "MULTIMAX - RESTAURANTE "
            }
          },
        ]);
        request.response
          ..statusCode = HttpStatus.ok
          ..write(reply)
          ..close();
      } else if (request.uri.toString().contains('get-detalles-facturas-pendientes')) {
        await Future.delayed(Duration(seconds: apiDelay));
        final reply = jsonEncode([
          {
            "ejefac": 20,
            "numfac": 3562,
            "fecfac": "2020-03-24T00:00:00.000Z",
            "fecven": "2020-03-25T00:00:00.000Z",
            "imprec": 624.46,
            "impcob": 0,
            "restofactura": 624.46,
          },
          {
            "ejefac": 21,
            "numfac": 3561,
            "fecfac": "2020-03-24T00:00:00.000Z",
            "fecven": "2020-03-25T00:00:00.000Z",
            "imprec": 624.46,
            "impcob": 0,
            "restofactura": 624.46,
          },
          {
            "ejefac": 23,
            "numfac": 3462,
            "fecfac": "2020-03-24T00:00:00.000Z",
            "fecven": "2020-03-25T00:00:00.000Z",
            "imprec": 624.46,
            "impcob": 0,
            "restofactura": 624.46,
          },
        ]);
        request.response
          ..statusCode = HttpStatus.ok
          ..write(reply)
          ..close();
      }
    }
  }

}