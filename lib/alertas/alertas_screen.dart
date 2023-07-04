import 'package:bys_app/albaran_pendiente_por_facturar/bloc/albaran_bloc.dart';
import 'package:bys_app/albaran_pendiente_por_facturar/model/albaran.dart';
import 'package:bys_app/alertas/bloc/alertas_bloc.dart';
import 'package:bys_app/clientes_del_dia/saveAlertadialog.dart';
import 'package:bys_app/general/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bys_app/alertas/model/Alerta.dart';

class AlertasScreen extends StatelessWidget {
  const AlertasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AlertasBloc>().add(LoadAlertas());
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(142, 11, 44, 1),
            title: Text('Alertas')),
        body: AlertasList());
  }
}

class AlertasList extends StatefulWidget {
  const AlertasList({Key? key}) : super(key: key);

  @override
  State<AlertasList> createState() => _AlertasList();
}

class _AlertasList extends State<AlertasList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlertasBloc, AlertasState>(builder: (context, state) {
      if (state is AlertasLoaded) {
        context.read<AlbaranBloc>();
        return Container(
            child: Column(
          children: <Widget>[
            Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                          showCheckboxColumn: false,
                          headingRowColor:
                              MaterialStateProperty.resolveWith<Color>(
                                  (states) =>
                                      const Color.fromRGBO(142, 11, 44, 1)),
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Cliente',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Descripcion',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Fecha',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                          rows: state is AlertasLoaded
                              ? listado(state.alertas)
                              : []),
                    ))),
          ],
        ));
      } else if (state is AlbaranLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return SizedBox.shrink();
      }
    });
  }

  List<DataRow> listado(List<Alerta>? alertas) {
    List<DataRow> resultado = [];
    if (alertas == null) return [];
    alertas.forEach((alerta) {
      resultado.add(DataRow(
          cells: <DataCell>[
            DataCell(Text(alerta.Cliente.toString())),
            DataCell(Text(alerta.comentario.toString())),
            DataCell(
                Text(GlobalConstants.format_with_time.format(alerta.fecha))),
          ],
          onSelectChanged: (val) {
            if (val == true) {
              SaveAlertaDialog.openDialogWithData(context, alerta: alerta);
            }
          }));
    });
    return resultado;
  }
}
