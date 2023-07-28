import 'package:bys_app/general/const.dart';
import 'package:flutter/material.dart';
import 'package:bys_app/pedidos/models/FacturaPendiente.dart';
import 'package:intl/intl.dart';
import 'package:bys_app/pedidos/models/FacturaAlbaran.dart';

class AlbaranesDialog {
  static void openAlbaranesDialogWithData(
      BuildContext context, List<FacturaAlbaran> detalles) {
    List<DataRow> elementos(List<FacturaAlbaran> detalles) {
      List<DataRow> result = [];
      detalles.forEach((element) {
        result.add(DataRow(cells: [
          DataCell(Text(element.numalb.toString())),
          DataCell(Text(element.codart.toString())),
          DataCell(Text(element.desmod.toString())),
          DataCell(Text(element.canser.toString())),
          DataCell(Text(element.preven.toString())),
          DataCell(Text((element.canser * element.preven).toString())),
          DataCell(Text(GlobalConstants.format.format(element.fecgar!))),
        ]));
      });
      return result;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextStyle estilo = TextStyle(color: Colors.white);
        return AlertDialog(
          title: Text('Albaranes'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => const Color.fromRGBO(142, 11, 44, 1)),
                      columns: [
                        DataColumn(
                            label: Text(
                          'Albarán',
                          style: estilo,
                        )),
                        DataColumn(
                            label: Text(
                          'Cod.',
                          style: estilo,
                        )),
                        DataColumn(
                            label: Text(
                          'Descripción',
                          style: estilo,
                        )),
                        DataColumn(
                            label: Text(
                          'Uni.',
                          style: estilo,
                        )),
                        DataColumn(
                            label: Text(
                          'Precio',
                          style: estilo,
                        )),
                        DataColumn(
                            label: Text(
                          'Subtot',
                          style: estilo,
                        )),
                        DataColumn(
                            label: Text(
                          'F. Graba',
                          style: estilo,
                        )),
                      ],
                      rows: elementos(detalles),
                    ),
                  ))
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(142, 11, 44, 1)),
              child: Text('Ok'),
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
