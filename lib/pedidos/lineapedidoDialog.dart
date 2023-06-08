import 'package:bys_app/general/const.dart';
import 'package:bys_app/productos/bloc/productos_bloc.dart';
import 'package:bys_app/productos/models/producto.dart';
import 'package:flutter/material.dart';
import 'package:bys_app/pedidos/models/FacturaPendiente.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class LineaPedidoDialog {
  static void openDialogWithData(BuildContext context) {
    List<DataRow> elementos(List<Producto> detalles) {
      List<DataRow> result = [];
      detalles.forEach((element) {
        result.add(DataRow(cells: [
          DataCell(Text(element.codart.toString())),
          DataCell(Text(element.des)),
          DataCell(Text(element.sto.toString())),
        ]));
      });
      return result;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar Articulos'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 200,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: BlocBuilder<ProductosBloc, ProductosState>(
                          builder: (context, state) => DataTable(
                            columns: [
                              DataColumn(label: Text('Cod. Art.')),
                              DataColumn(label: Text('Descripción')),
                              DataColumn(label: Text('Stock')),
                            ],
                            rows: elementos(state.productos),
                          ),
                        ))),
              )
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(142, 11, 44, 1)),
              child: Text('Confirme la comunicación'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
