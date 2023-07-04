import 'package:bys_app/albaran_pendiente_por_facturar/bloc/albaran_bloc.dart';
import 'package:bys_app/albaran_pendiente_por_facturar/model/albaran.dart';
import 'package:bys_app/alertas/bloc/alertas_bloc.dart';
import 'package:bys_app/clientes_del_dia/historial_cliente/bloc/history_bloc.dart';
import 'package:bys_app/clientes_del_dia/saveAlertadialog.dart';
import 'package:bys_app/cobros/bloc/cobros_bloc.dart';
import 'package:bys_app/general/const.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:bys_app/inicio_sesion/model/ClientesDia.dart';
import 'package:bys_app/pedidos/bloc/pedidos_bloc.dart';
import 'package:bys_app/pedidos/pedidos_dia/bloc/pedidos_dia_bloc.dart';
import 'package:bys_app/productos/bloc/productos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bys_app/pedidos/pedidos_dia/model/PedidoDia.dart';

class PedidosDiaScreen extends StatelessWidget {
  const PedidosDiaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PedidosDiaBloc>().add(LoadPedidosDia());
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(142, 11, 44, 1),
            title: Text('Pedidos del dia')),
        body: PedidosDiasList());
  }
}

class PedidosDiasList extends StatefulWidget {
  const PedidosDiasList({Key? key}) : super(key: key);

  @override
  State<PedidosDiasList> createState() => _PedidosDiasList();
}

class _PedidosDiasList extends State<PedidosDiasList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PedidosDiaBloc, PedidosDiaState>(
        builder: (context, state) {
      if (state is PedidosDiaLoaded) {
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
                                  'Código Cliente',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Nombre Cliente',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Fecha Pedido',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Total Pedido',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                          rows: listado(state.pedidos ?? [])),
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

  List<DataRow> listado(List<PedidoDia>? pedidos) {
    List<DataRow> resultado = [];
    if (pedidos == null) return [];
    pedidos.forEach((pedido) {
      resultado.add(DataRow(
          cells: <DataCell>[
            DataCell(Text(pedido.codcli.toString())),
            DataCell(Text(pedido.cliente.toString())),
            DataCell(Text(GlobalConstants.format.format(pedido.fecped))),
            DataCell(Text(pedido.totped.toString())),
          ],
          onSelectChanged: (selected) {
            if (selected != null && selected) {
              context.read<ClientesdiaBloc>().add(SelectClienteDia(ClientesDia(
                  codcli: pedido.codcli,
                  ordenvisit: '1',
                  ampm: '1',
                  Ordgeo2: 1,
                  Ordgeo1: 1,
                  cal2: pedido.cliente,
                  nom: pedido.cliente)));
              context.read<CobrosBloc>().add(CheckDeudaEvent(pedido.codcli));
              context.read<ProductosBloc>().add(LoadProductos(pedido.codcli));
              context.read<PedidosBloc>().add(GetPedidoCliente(pedido.codcli));

              context
                  .read<HistoryBloc>()
                  .add(LoadHistory(codcli: pedido.codcli));
              Navigator.of(context).pushNamed('zona_clientes');
              context
                  .read<AlbaranBloc>()
                  .add(LoadAlbaran(codcli: pedido.codcli));
            }
          }));
    });
    return resultado;
  }
}
