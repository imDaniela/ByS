import 'package:bys_app/cobros_unificados/cobros/AlbaranesDialog.dart';
import 'package:bys_app/cobros_unificados/cobros/bloc/cobros_bloc.dart';
import 'package:bys_app/cobros_unificados/cobros/datepicker.dart';
import 'package:bys_app/cobros_unificados/cobros/select.dart';
import 'package:bys_app/general/const.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bys_app/pedidos/models/FacturaAlbaran.dart';

enum PaymentMethod { contado, datafono, cheque, transferencia }

class CobroDialog {
  static void openDialogWithData(BuildContext context, double pendiente,
      int numfac, List<FacturaAlbaran> albaranes) {
    TextEditingController _controller = TextEditingController();
    TextEditingController _datecontroller = TextEditingController();
    String metodo = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        _controller.text = pendiente.toString();
        _datecontroller.text = GlobalConstants.getHoyString();
        return AlertDialog(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Cobros Pendientes'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(142, 11, 44, 1)),
              child: Icon(Icons.local_shipping),
              onPressed: () {
                AlbaranesDialog.openAlbaranesDialogWithData(context, albaranes);
              },
            ),
          ]),
          content: SingleChildScrollView(
            child: Column(
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

                          filled:
                              true, // Enable filling the TextField background
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
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text('Metodos:')),
                SelectMetodo(onChanged: (val) {
                  metodo = val;
                })
              ],
            ),
          ),
          actions: [
            BlocBuilder<ClientesdiaBloc, ClientesdiaState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(142, 11, 44, 1)),
                      child: Text('Anular Cobro'),
                      onPressed: () {
                        if (state is ClientesdiaLoaded) {
                          ClientesdiaLoaded estado = state as ClientesdiaLoaded;
                          DateTime fecha = GlobalConstants.format
                              .parse(_datecontroller.text);
                          context.read<CobrosBloc>().add(DeleteCobroEvent(
                                codcli: estado.cliente!.codcli,
                                numfac: numfac,
                              ));
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(142, 11, 44, 1)),
                      child: Text('Confirmar Cobro'),
                      onPressed: () {
                        if (state is ClientesdiaLoaded) {
                          ClientesdiaLoaded estado = state as ClientesdiaLoaded;
                          DateTime fecha = GlobalConstants.format
                              .parse(_datecontroller.text);
                          context.read<CobrosBloc>().add(SaveCobroEvent(
                              codcli: estado.cliente!.codcli,
                              numfac: numfac,
                              forma_pago: metodo,
                              cobro: double.tryParse(_controller.text) ?? 0,
                              fecha: fecha));
                        }
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              },
            )
          ],
        );
      },
    );
  }
}
