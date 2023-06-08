import 'package:bys_app/clientes_del_dia/bloc/cliente_bloc.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:bys_app/pedidos/bloc/pedidos_bloc.dart';
import 'package:bys_app/pedidos/deudaDialog.dart';
import 'package:bys_app/pedidos/lineapedidoDialog.dart';
import 'package:bys_app/pedidos/models/PedidoLinea.dart';
import 'package:bys_app/productos/models/producto.dart';
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
            body: BlocBuilder<PedidosBloc, PedidosState>(
                builder: (context, state) => Container(
                        child: Column(
                      children: <Widget>[
                        Expanded(
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: DataTable(
                                      showCheckboxColumn: false,
                                      headingRowColor: MaterialStateProperty
                                          .resolveWith<Color>((states) =>
                                              const Color.fromRGBO(
                                                  142, 11, 44, 1)),
                                      columns: const <DataColumn>[
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
                                              'Descripción',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Text(
                                              'Cantidad',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Text(
                                              'Precio',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Text(
                                              '% Dto',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Text(
                                              'SubTotal',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: SizedBox(
                                            width: 1000,
                                            child: Text(
                                              'Accion',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: state is PedidoBuilding
                                          ? listado(state.lineas)
                                          : []),
                                ))),
                      ],
                    ))));
      },
    );
  }

  List<DataRow> listado(List<PedidoLinea>? lineas) {
    List<DataRow> resultado = [];
    if (lineas == null) return [];
    for (int index = 0; index < lineas.length; index++) {
      PedidoLinea linea = lineas[index];

      double subtotal = linea.cantidad * linea.precio;
      resultado.add(DataRow(
          cells: <DataCell>[
            DataCell(Text(linea.codart.toString())),
            DataCell(Text(linea.nombre ?? '')),
            DataCell(Text(linea.cantidad.toString())),
            DataCell(Text(linea.precio.toString())),
            DataCell(Text('0')),
            DataCell(Text(subtotal.toStringAsFixed(2))),
            DataCell(Text(''))
          ],
          onSelectChanged: (value) => {
                if (value == true)
                  {
                    LineaPedido2Dialog.openDialogWithData(
                        context,
                        Producto(
                            codart: linea.codart,
                            des: linea.nombre ?? '',
                            sto: linea.sto,
                            prevena: linea.precio),
                        index: int.parse(index.toString()),
                        cantidad: linea.cantidad)
                  }
              }));
    }

    return resultado;
  }
}
