import 'package:bys_app/general/const.dart';
import 'package:flutter/material.dart';
import 'package:bys_app/pedidos/models/FacturaPendiente.dart';

class DialogHelper {
  static void openDialogWithData(
      BuildContext context, double number, List<FacturaPendiente> detalles) {
    List<DataRow> elementos(List<FacturaPendiente> detalles) {
      List<DataRow> result = [];
      detalles.forEach((element) {
        if ((element.impcob ?? 0) < (element.imprec ?? 0)) {
          result.add(DataRow(cells: [
            DataCell(Text(element.numfac.toString())),
            DataCell(Text(GlobalConstants.format.format(element.fecfac!))),
            DataCell(Text(GlobalConstants.format.format(element.fecven!))),
            DataCell(Text(element.imprec?.toStringAsFixed(2) ?? '0.00')),
            DataCell(Text(element.restofactura?.toStringAsFixed(2) ?? '0.00')),
            DataCell(Text(element.cobrohoy?.toStringAsFixed(2) ?? '0.00')),
          ]));
        }
      });
      return result;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Facturas Pendientes'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  children: [
                    TextSpan(
                      style: TextStyle(
                        color: Colors
                            .black, // Change the number's text color to red
                      ),
                      text:
                          'El departamento Financiero le informa que el cliente tiene un saldo pendiente de ',
                    ),
                    TextSpan(
                      text: number.toString(),
                      style: TextStyle(
                        color:
                            Colors.red, // Change the number's text color to red
                      ),
                    ),
                    TextSpan(
                      style: TextStyle(
                        color: Colors
                            .black, // Change the number's text color to red
                      ),
                      text:
                          '.\nEs posible que el pedido pueda ser retenido. Comuníquelo al cliente.',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('Nº Factura')),
                        DataColumn(label: Text('F. Factura')),
                        DataColumn(label: Text('F. Venc')),
                        DataColumn(label: Text('Importe')),
                        DataColumn(label: Text('Pendiente')),
                        DataColumn(label: Text('C. Hoy')),
                      ],
                      rows: elementos(detalles),
                    ),
                  )),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Text(
                  'Total: ${number.toStringAsFixed(2)}',
                  textAlign: TextAlign.end,
                  style: TextStyle(),
                ),
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
