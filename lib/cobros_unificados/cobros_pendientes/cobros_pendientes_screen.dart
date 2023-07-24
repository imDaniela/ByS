import 'package:bys_app/cobros_unificados/cobros/bloc/cobros_bloc.dart';
import 'package:bys_app/cobros_unificados/cobros/models/cobro.dart';
import 'package:bys_app/cobros_unificados/cobros/saveCobroDialog.dart';
import 'package:bys_app/cobros_unificados/cobros_dialog_helper.dart';
import 'package:bys_app/cobros_unificados/cobros_pendientes/bloc/cobros_pendientes_state.dart';
import 'package:bys_app/cobros_unificados/cobros_pendientes/models/cobro_pendiente.dart';
import 'package:bys_app/general/const.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:bys_app/pedidos/models/ClienteSaldoPendiente.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CobrosPendientesScreen extends StatefulWidget {
  const CobrosPendientesScreen({
    this.state,
    Key? key}) : super(key: key);
  final CobrosPendientesState? state;
  @override
  State<CobrosPendientesScreen> createState() => _CobrosPendientesScreen();
}

class _CobrosPendientesScreen extends State<CobrosPendientesScreen> {
  @override
  Widget build(BuildContext context) {
    return _body(state: widget.state!);
  }

  Widget _body({required CobrosPendientesState state}) {
    return Column(
      children: <Widget>[
        Container(
            width: 1000000,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                      showCheckboxColumn: false,
                      headingRowColor: MaterialStateProperty
                          .resolveWith<Color>((states) =>
                              const Color.fromRGBO(142, 11, 44, 1)),
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Codigo',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Nombre Fiscal',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Nombre Comercio',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Total Pendiente',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                      rows: state is CobrosPedientesBuilding
                          ? listado(
                              (state).cobros)
                          : []),
                ))),
        state is CobrosPendientesLoading
            ? Expanded(
                flex: 5,
                child: Center(child: CircularProgressIndicator()))
            : Container(),
      ],
    );
  }

  List<DataRow> listado(List<CobroPendiente> cobros) {
    List<DataRow> resultado = [];
    cobros.forEach((cobro) {
      resultado.add(DataRow(
          color: MaterialStateProperty.all(((cobro.importe ?? 0) >= 1000) ? Colors.red.withOpacity(0.8) : Colors.blue.withOpacity(0.8)),
          cells: <DataCell>[
            DataCell(Text(cobro.codigoCliente.toString())),
            DataCell(Text(cobro.nombreFiscal.toString())),
            DataCell(Text(cobro.nombreComercial.toString())),
            DataCell(Text(cobro.importe.toString())),
          ],
          onSelectChanged: (bool? selected) {
            CobrosDialogHelper.openCobrosPendientesDialogWithData(context, cobro.codigoCliente!);
            // CobroDialog.openDialogWithData(context, saldo.restofactura ?? 0,
            //     saldo.numfac!, saldo.albfaclis ?? []);
            /*if (selected != null && selected) {
              context.read<ClientesdiaBloc>().add(SelectClienteDia(cliente));
              context.read<CobrosBloc>().add(CheckDeudaEvent(cliente.codcli));
              context.read<ProductosBloc>().add(LoadProductos(cliente.codcli));
              context
                  .read<HistoryBloc>()
                  .add(LoadHistory(codcli: cliente.codcli));
              Navigator.of(context).pushNamed('zona_clientes');
            }*/
          }));
    });
    return resultado;
  }
}
