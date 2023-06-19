import 'package:bys_app/cobros/datepicker.dart';
import 'package:bys_app/cobros/select.dart';
import 'package:bys_app/general/const.dart';
import 'package:flutter/material.dart';
import 'package:bys_app/pedidos/models/FacturaPendiente.dart';
import 'package:intl/intl.dart';

enum PaymentMethod { contado, datafono, cheque, transferencia }

class CobroDialog {
  static void openDialogWithData(
      BuildContext context, double pendiente, int numfac) {
    TextEditingController _controller = TextEditingController();
    TextEditingController _datecontroller = TextEditingController();

    PaymentMethod selectedPaymentMethod;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cobros Pendientes'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text('Pendiente: ${pendiente}')),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text('Importe:')),
              Container(
                  width: 10000000,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _controller,
                      cursorColor: const Color.fromRGBO(142, 11, 44, 1),
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50.0),
                        ),

                        filled: true, // Enable filling the TextField background
                        fillColor: const Color.fromRGBO(
                            212, 212, 212, 1), // Set the background color
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(142, 11, 44,
                                  1)), // Set the border color when focused
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ))),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text('Fecha:')),
              DatePicker(controller: _datecontroller),
              SelectMetodo()
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
