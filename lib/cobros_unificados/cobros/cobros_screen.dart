import 'package:bys_app/cobros_unificados/cobros/bloc/cobros_bloc.dart';
import 'package:bys_app/cobros_unificados/cobros/models/cobro.dart';
import 'package:bys_app/cobros_unificados/cobros/saveCobroDialog.dart';
import 'package:bys_app/cobros_unificados/cobros_dialog_helper.dart';
import 'package:bys_app/general/const.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:bys_app/pedidos/models/ClienteSaldoPendiente.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CobrosScreen extends StatefulWidget {
  const CobrosScreen({
    this.state,
    Key? key}) : super(key: key);
  final CobrosState? state;
  @override
  State<CobrosScreen> createState() => _CobrosScreen();
}

class _CobrosScreen extends State<CobrosScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.state == null ? BlocConsumer<CobrosBloc, CobrosState>(
        listener: (context, state) {
          if (state is CobrosSuccess) {
            Fluttertoast.showToast(
                msg: "Se ha rehow alizado el cobro con éxito",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Color.fromARGB(255, 0, 155, 0),
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) => _body(state: state))
      : _body(state: widget.state!);
  }

  Widget _body({required CobrosState state}) {
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
                      rows: state is CobrosBuilding
                          ? listado(
                              (state).cobros)
                          : []),
                ))),
        state is CobroLoading
            ? Expanded(
                flex: 5,
                child: Center(child: CircularProgressIndicator()))
            : Container(),
      ],
    );
  }

  List<DataRow> listado(List<Cobro> cobros) {
    List<DataRow> resultado = [];
    cobros.forEach((cobro) {
      resultado.add(DataRow(
          cells: <DataCell>[
            DataCell(Text(cobro.codigoCliente.toString())),
            DataCell(Text(cobro.nombre.toString())),
            DataCell(Text(cobro.nombreComercio.toString())),
            DataCell(Text(cobro.numeroFactura.toString())),
            DataCell(Text(cobro.fechaFactura.toString())),
            DataCell(Text(cobro.importe.toString())),
            DataCell(Text(cobro.formaPago.toString())),
          ],
          onSelectChanged: (bool? selected) {
            CobrosDialogHelper.openCobrosDialogWithData(context, cobro.numeroFactura!);
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