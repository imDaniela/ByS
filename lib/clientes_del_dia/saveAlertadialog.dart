import 'package:bys_app/alertas/bloc/alertas_bloc.dart';
import 'package:bys_app/alertas/model/Alerta.dart';
import 'package:bys_app/cobros/AlbaranesDialog.dart';
import 'package:bys_app/cobros/bloc/cobros_bloc.dart';
import 'package:bys_app/cobros/datepicker.dart';
import 'package:bys_app/cobros/select.dart';
import 'package:bys_app/general/const.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:bys_app/inicio_sesion/model/ClientesDia.dart';
import 'package:flutter/material.dart';
import 'package:bys_app/pedidos/models/FacturaPendiente.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:bys_app/pedidos/models/FacturaAlbaran.dart';

class SaveAlertaDialog {
  static void openDialogWithData(BuildContext context,
      {ClientesDia? cliente, Alerta? alerta}) {
    TextEditingController _controller = TextEditingController();
    TextEditingController _datecontroller = TextEditingController();
    String metodo = '';
    if (alerta != null) {
      _controller.text = alerta.comentario;
      _datecontroller.text =
          GlobalConstants.format_with_time.format(alerta.fecha);
    } else {
      _datecontroller.text = GlobalConstants.getHoyString(time: true);
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Guardar Alerta'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text('Fecha:')),
                DatePicker(
                  controller: _datecontroller,
                  show_time: true,
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text('Comentario:')),
                Container(
                    width: 10000000,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                        maxLines: 5,
                        minLines: 5,
                        controller: _controller,
                        cursorColor: const Color.fromRGBO(142, 11, 44, 1),
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15.0),
                          ),

                          filled:
                              true, // Enable filling the TextField background
                          fillColor: const Color.fromRGBO(
                              212, 212, 212, 1), // Set the background color
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(142, 11, 44,
                                    1)), // Set the border color when focused
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ))),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                alerta != null
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(142, 11, 44, 1)),
                        child: Text('Eliminar Alerta'),
                        onPressed: () {
                          context
                              .read<AlertasBloc>()
                              .add(deleteAlertas(alerta!.id));
                          Navigator.of(context).pop();
                        },
                      )
                    : Container(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(142, 11, 44, 1)),
                  child: Text('Guardar Alerta'),
                  onPressed: () {
                    DateTime _fecha = GlobalConstants.format_with_time
                        .parse(_datecontroller.text);

                    context.read<AlertasBloc>().add(SaveAlerta(
                        id: alerta != null ? alerta.id : null,
                        codcli: alerta != null
                            ? alerta.id_cliente
                            : (cliente!.codcli),
                        descripcion: _controller.text,
                        fecha: _fecha,
                        cliente: alerta != null
                            ? alerta.Cliente ?? ''
                            : (cliente!.cal2)));

                    Navigator.of(context).pop();
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }
}
