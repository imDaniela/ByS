import 'package:bys_app/clientes_del_dia/day_selector.dart';
import 'package:bys_app/clientes_del_dia/historial_cliente/bloc/history_bloc.dart';
import 'package:bys_app/cobros/bloc/cobros_bloc.dart';
import 'package:bys_app/cobros/saveCobroDialog.dart';
import 'package:bys_app/general/const.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:bys_app/inicio_sesion/model/ClientesDia.dart';
import 'package:bys_app/pedidos/bloc/pedidos_bloc.dart';
import 'package:bys_app/pedidos/models/ClienteSaldoPendiente.dart';
import 'package:bys_app/productos/bloc/productos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bys_app/componentes_comunes/navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CobrosScreen extends StatefulWidget {
  const CobrosScreen({Key? key}) : super(key: key);

  @override
  State<CobrosScreen> createState() => _CobrosScreen();
}

class _CobrosScreen extends State<CobrosScreen> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocBuilder<CobrosBloc, CobrosState>(
            builder: (context, state) => Column(
                  children: <Widget>[
                    Container(
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
                                          'Nº Factura',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text(
                                          'F. Factura',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text(
                                          'F. Venc',
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
                                          'Pendiente',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: SizedBox(
                                        child: Text(
                                          'C. Hoy',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: SizedBox(
                                        child: Text(
                                          'FP',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: state is CobrosPendientes
                                      ? listado(
                                          (state as CobrosPendientes).deuda)
                                      : []),
                            ))),
                    state is ClientesdiaLoading
                        ? Expanded(
                            flex: 5,
                            child: Center(child: CircularProgressIndicator()))
                        : Container()
                  ],
                )));
  }

  List<DataRow> listado(ClienteSaldoPendiente? clientes) {
    List<DataRow> resultado = [];
    if (clientes == null) return [];
    clientes.detalles.forEach((saldo) {
      resultado.add(DataRow(
          cells: <DataCell>[
            DataCell(Text(saldo.numfac.toString())),
            DataCell(Text(GlobalConstants.format.format(saldo.fecfac!))),
            DataCell(Text(GlobalConstants.format.format(saldo.fecven!))),
            DataCell(Text(saldo.impcob.toString())),
            DataCell(Text(saldo.imprec.toString())),
            DataCell(Text('0')),
            DataCell(Text('PV'))
          ],
          onSelectChanged: (bool? selected) {
            CobroDialog.openDialogWithData(
                context, saldo.imprec ?? 0, saldo.numfac!);
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