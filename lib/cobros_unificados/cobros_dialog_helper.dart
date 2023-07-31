import 'dart:convert';

import 'package:bys_app/cobros_unificados/cobros/api/cobros_realizados_api.dart';
import 'package:bys_app/cobros_unificados/cobros/models/cobro.dart';
import 'package:bys_app/cobros_unificados/cobros_pendientes/api/cobros_pendientes_api.dart';
import 'package:bys_app/cobros_unificados/cobros_pendientes/models/cobro_pendiente_detalles.dart';
import 'package:flutter/material.dart';

class CobrosDialogHelper {

  static void openCobrosDialogWithData(
      BuildContext context, int number) async {
    List<DataRow> elementos(List<Cobro> cobros) {
      List<DataRow> result = [];
      for (var element in cobros) {
        result.add(DataRow(cells: [
          DataCell(Text(element.codigoCliente.toString())),
          DataCell(Text(element.nombre.toString())),
          DataCell(Text(element.nombreComercio.toString())),
          DataCell(Text(element.fechaFactura.toString())),
          DataCell(Text(element.importe.toString())),
          DataCell(Text(element.formaPago.toString())),
          DataCell(Text(element.canal.toString())),
        ]));
      }
      return result;
    }

    showDialog(context: context, barrierDismissible: false, builder: (context) {
      return const Center(child: CircularProgressIndicator());
    });
    await CobrosRealizadosApi.getDetalles(numeroFactura: number).then((response) {
      final detalles = <Cobro>[];
      if (response.statusCode == 200 && response.body != 'null') {
        List<dynamic> body = jsonDecode(response.body);
        for (final linea in body) {
          detalles.add(Cobro.fromMap(linea));
        }
      }
      Navigator.pop(context);
      if (detalles.isNotEmpty) {
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Detalles de Cobro'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Codigo Cliente')),
                          DataColumn(label: Text('Nombre Fiscal')),
                          DataColumn(label: Text('Nombre Comercial')),
                          DataColumn(label: Text('Fecha Factura')),
                          DataColumn(label: Text('Importe')),
                          DataColumn(label: Text('F.P.')),
                          DataColumn(label: Text('Canal')),
                        ],
                        rows: elementos(detalles),
                      ),
                    ))
              ],
            ),
          );
        },
    );
    }});
    
  }

  static void openCobrosPendientesDialogWithData(
      BuildContext context, int codigoCliente) async {
    List<DataRow> elementos(List<CobroPendienteDetalles> cobros) {
      List<DataRow> result = [];
      for (var element in cobros) {
        result.add(DataRow(cells: [
          DataCell(Text(element.numeroFactura.toString())),
          DataCell(Text(element.fechaFactura.toString())),
          DataCell(Text(element.fechaVencimiento.toString())),
          DataCell(Text(element.importe.toString())),
          DataCell(Text(element.importePendiente.toString())),
        ]));
      }
      return result;
    }

    showDialog(context: context, barrierDismissible: false, builder: (context) {
      return const Center(child: CircularProgressIndicator());
    });
    await CobrosPendientesApi.getDetalles(codigoCliente: codigoCliente).then((response) {
      final detalles = <CobroPendienteDetalles>[];
      if (response.statusCode == 200 && response.body != 'null') {
        List<dynamic> body = jsonDecode(response.body);
        for (final linea in body) {
          detalles.add(CobroPendienteDetalles.fromMap(linea));
        }
      }
      Navigator.pop(context);
      if (detalles.isNotEmpty) {
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Detalles de Cobro'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Numero Factura')),
                          DataColumn(label: Text('Fecha Factura')),
                          DataColumn(label: Text('Fecha Vencimiento')),
                          DataColumn(label: Text('Importe')),
                          DataColumn(label: Text('Importe Pendiente')),
                        ],
                        rows: elementos(detalles),
                      ),
                    ))
              ],
            ),
          );
        },
    );
    }});
    
  }

}