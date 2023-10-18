import 'package:bys_app/cobros_unificados/cobros/bloc/cobros_realizados_bloc.dart';
import 'package:bys_app/cobros_unificados/cobros/bloc/cobros_realizados_state.dart';
import 'package:bys_app/cobros_unificados/cobros/models/cobro.dart';
import 'package:bys_app/cobros_unificados/cobros_dialog_helper.dart';
import 'package:bys_app/cobros_unificados/cobros_pendientes/bloc/cobros_pendientes_state.dart';
import 'package:bys_app/general/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CobrosRealizadosScreen extends StatefulWidget {
  final String metodo;
  const CobrosRealizadosScreen({this.state, Key? key, required this.metodo})
      : super(key: key);
  final CobrosRealizadosState? state;
  @override
  State<CobrosRealizadosScreen> createState() => _CobrosScreen();
}

class _CobrosScreen extends State<CobrosRealizadosScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.state == null
        ? BlocConsumer<CobrosRealizadosBloc, CobrosRealizadosState>(
            listener: (context, state) {
              if (state is CobrosRealizadosSuccess) {
                Fluttertoast.showToast(
                    msg: "Se ha realizado el cobro con éxito",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color.fromARGB(255, 0, 155, 0),
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            builder: (context, state) =>
                _body(state: state, metodo: widget.metodo))
        : _body(state: widget.state!, metodo: widget.metodo);
  }

  Widget _body({required CobrosRealizadosState state, required String metodo}) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
              width: 1000000,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                        showCheckboxColumn: false,
                        headingRowColor:
                            MaterialStateProperty.resolveWith<Color>((states) =>
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
                                'Numero de Factura',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Fecha de cobro',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Importe',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'F.P.',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                        rows: state is CobrosRealizadosBuilding
                            ? listado(state, metodo)
                            : []),
                  ))),
        ),
        state is CobrosRealizadosLoading
            ? Expanded(
                flex: 5, child: Center(child: CircularProgressIndicator()))
            : Container(),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          alignment: Alignment.bottomLeft,
          child: Text(
            'Total: ${Total(state is CobrosRealizadosBuilding ? (state).cobros : [])}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        )
      ],
    );
  }

  String Total(List<Cobro> cobros) {
    double result = 0;
    cobros.forEach((element) {
      result += element.importe ?? 0;
    });
    return result.toString();
  }

  List<DataRow> listado(CobrosRealizadosBuilding state, String metodo) {
    List<DataRow> resultado = [];
    state.cobros.forEach((cobro) {
      resultado.add(DataRow(
          cells: <DataCell>[
            DataCell(Text(cobro.codigoCliente.toString())),
            DataCell(Text(cobro.nombre.toString())),
            DataCell(Text(cobro.nombreComercio.toString())),
            DataCell(Text(cobro.numeroFactura.toString())),
            DataCell(Text(GlobalConstants.format
                .format(DateTime.parse(cobro.fechaFactura!)))),
            DataCell(Text(cobro.importe.toString())),
            DataCell(Text(cobro.formaPago.toString())),
          ],
          onSelectChanged: (bool? selected) {
            CobrosDialogHelper.openCobrosDialogWithData(
                context, cobro.numeroFactura!,
                metodo: metodo, inicio: state.inicio, fin: state.fin);
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
