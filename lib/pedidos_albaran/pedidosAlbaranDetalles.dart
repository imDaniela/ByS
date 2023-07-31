import 'dart:convert';

import 'package:bys_app/general/const.dart';
import 'package:bys_app/pedidos_albaran/api/pedidos_albaran_api.dart';
import 'package:bys_app/pedidos_albaran/models/pedidoAlbaranDetalles.dart';
import 'package:flutter/material.dart';

class AlbaranDialogHelper {
  static void openDialogWithData(BuildContext context, int number) async {
    List<DataRow> elementos(List<PedidoAlbaranDetalles> detalles) {
      List<DataRow> result = [];
      for (var element in detalles) {
        result.add(DataRow(cells: [
          DataCell(Text(element.numeroAlbaran.toString())),
          DataCell(Text(element.codigoArticulo.toString())),
          DataCell(Text(element.cantidadArticulo.toString())),
          DataCell(Text(element.precioVenta?.toStringAsFixed(2) ?? '')),
          DataCell(Text(element.subtotal?.toStringAsFixed(2) ?? '')),
          DataCell(Text(GlobalConstants.format
              .format(DateTime.parse(element.fechaCreacion ?? '')))),
          DataCell(Text(element.descripcion ?? '')),
        ]));
      }
      return result;
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(child: const CircularProgressIndicator());
        });
    await PedidosAlbaranApi.getPedido(number).then((response) {
      final detalles = <PedidoAlbaranDetalles>[];
      if (response.statusCode == 200 && response.body != 'null') {
        List<dynamic> body = jsonDecode(response.body);
        for (final linea in body) {
          detalles.add(PedidoAlbaranDetalles.fromMap(linea));
        }
      }
      Navigator.pop(context);
      if (detalles.isNotEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Detalles de Albaran'),
              content: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Nº Albaran')),
                        DataColumn(label: Text('Codigo Articulo')),
                        DataColumn(label: Text('Cantidad')),
                        DataColumn(label: Text('Precio Venta')),
                        DataColumn(label: Text('Subtotal')),
                        DataColumn(label: Text('Fecha Creacion')),
                        DataColumn(label: Text('Descripcion')),
                      ],
                      rows: elementos(detalles),
                    ),
                  )),
            );
          },
        );
      }
    });
  }
}
