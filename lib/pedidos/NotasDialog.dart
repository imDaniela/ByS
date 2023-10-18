import 'package:bys_app/general/const.dart';
import 'package:bys_app/pedidos/bloc/pedidos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bys_app/pedidos/models/FacturaPendiente.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotasDialog {
  static void openDialogWithData(BuildContext context, int codcli,
      {String? default_obs, String? default_obs_int}) {
    TextEditingController _obsController = TextEditingController();
    TextEditingController _obsintController = TextEditingController();
    _obsController.text = default_obs ?? '';
    _obsintController.text = default_obs_int ?? '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notas del Pedido'),
          content: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text('En el Pedido'),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                      maxLines: 10,
                      minLines: 3,
                      keyboardType: TextInputType.text,
                      controller: _obsController,
                      cursorColor: const Color.fromRGBO(142, 11, 44, 1),
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        filled: true, // Enable filling the TextField background
                        fillColor: const Color.fromRGBO(
                            212, 212, 212, 1), // Set the background color
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(142, 11, 44,
                                  1)), // Set the border color when focused
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ))),
              Container(
                width: 10000000,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text('Interno'),
              ),
              Container(
                  width: 10000000,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                      maxLines: 10,
                      minLines: 3,
                      keyboardType: TextInputType.text,
                      controller: _obsintController,
                      cursorColor: const Color.fromRGBO(142, 11, 44, 1),
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        filled: true, // Enable filling the TextField background
                        fillColor: const Color.fromRGBO(
                            212, 212, 212, 1), // Set the background color
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(142, 11, 44,
                                  1)), // Set the border color when focused
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ))),
            ],
          )),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(142, 11, 44, 1)),
              child: Text('Guardar Notas'),
              onPressed: () {
                context.read<PedidosBloc>().add(SavePedidoEvent(
                    codcli: codcli,
                    observaciones: _obsController.text,
                    intobs: _obsintController.text));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
