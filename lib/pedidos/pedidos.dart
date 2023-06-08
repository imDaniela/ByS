import 'package:bys_app/clientes_del_dia/bloc/cliente_bloc.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:bys_app/pedidos/bloc/pedidos_bloc.dart';
import 'package:bys_app/pedidos/deudaDialog.dart';
import 'package:bys_app/pedidos/lineapedidoDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PedidosScreen extends StatelessWidget {
  const PedidosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _PedidosScreen();
  }
}

class _PedidosScreen extends StatefulWidget {
  const _PedidosScreen({Key? key}) : super(key: key);

  @override
  State<_PedidosScreen> createState() => _PedidosScreenState();
}

class _PedidosScreenState extends State<_PedidosScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
        (_) => openDeudaDialog(context.read<PedidosBloc>().state));
  }

  void openDeudaDialog(PedidosState state) {
    print('a');
    if (state is PedidosDeuda) {
      DialogHelper.openDialogWithData(
          context, state.deuda.deuda, state.deuda.detalles);
      context.read<PedidosBloc>().add(InitPedidoBuild());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PedidosBloc, PedidosState>(
      listener: (context, state) {
        openDeudaDialog(state);
      },
      builder: (context, state) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  LineaPedidoDialog.openDialogWithData(context);
                },
                backgroundColor: Color.fromRGBO(142, 11, 44, 1)),
            body: Container(
                child: Column(
              children: <Widget>[
                Expanded(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                              headingRowColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (states) =>
                                          const Color.fromRGBO(142, 11, 44, 1)),
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Código',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Cod. Art',
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
                                      'Unid. Hoy',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Total año',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Mes 1',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Mes 2',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Mes 3',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Mes 4',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Mes 5',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Mes 6',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                              rows: []),
                        ))),
              ],
            )));
      },
    );
  }

  // List<DataRow> listado(List<ClientesDia>? clientes) {
  //   List<DataRow> resultado = [];
  //   if (clientes == null) return [];
  //   clientes.forEach((cliente) {
  //     resultado.add(DataRow(
  //       cells: <DataCell>[
  //         DataCell(Text(cliente.codcli.toString())),
  //         DataCell(Text(cliente.cal2)),
  //         DataCell(Text(cliente.ordenvisit)),
  //         DataCell(Text(cliente.ampm)),
  //         DataCell(Text('')),
  //         DataCell(Text(cliente.nom))
  //       ],
  //     ));
  //   });
  //   for (int i = 0; i < 100; i++) {}
  //   return resultado;
  // }
}