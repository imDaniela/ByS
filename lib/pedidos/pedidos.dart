import 'package:bys_app/clientes_del_dia/bloc/cliente_bloc.dart';
import 'package:bys_app/cobros/bloc/cobros_bloc.dart';
import 'package:bys_app/general/const.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:bys_app/pedidos/bloc/pedidos_bloc.dart';
import 'package:bys_app/pedidos/deudaDialog.dart';
import 'package:bys_app/pedidos/lineapedidoDialog.dart';
import 'package:bys_app/pedidos/models/PedidoLinea.dart';
import 'package:bys_app/productos/models/producto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    /*SchedulerBinding.instance.addPostFrameCallback(
        (_) => openDeudaDialog(context.read<CobrosBloc>().state));*/
  }

  void openDeudaDialog(CobrosState state) {
    if (state is CobrosPendientes) {
      if ((state as CobrosPendientes).showDialog) {
        DialogHelper.openDialogWithData(
            context, state.deuda.deuda, state.deuda.detalles);
        context.read<PedidosBloc>().add(InitPedidoBuild());
        context.read<CobrosBloc>().add(toggleDialogEvent(false));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CobrosBloc, CobrosState>(
        listener: (context, state_cobros) {
          openDeudaDialog(state_cobros);
        },
        child: BlocConsumer<PedidosBloc, PedidosState>(
          listener: (context, state) {
            if (state is PedidosSuccess) {
              Fluttertoast.showToast(
                  msg: "Se ha guardado el pedido con éxito",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Color.fromARGB(255, 0, 155, 0),
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          builder: (context, state) {
            return BlocBuilder<ClientesdiaBloc, ClientesdiaState>(
                builder: (context, state_cliente) => Scaffold(
                    floatingActionButton: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              width: 52,
                              height: 52,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  boxShadow: [BoxShadow()],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5000)),
                                  color: Color.fromRGBO(142, 11, 44, 1)),
                              child: InkWell(
                                onTap: () {
                                  LineaPedidoDialog.openDialogWithData(context);
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          state is PedidoBuilding
                              ? Container(
                                  child: state.lineas.length > 0
                                      ? FloatingActionButton(
                                          child: Icon(Icons.save),
                                          onPressed: () {
                                            if (state_cliente
                                                is ClientesdiaLoaded) {
                                              ClientesdiaLoaded esta =
                                                  state_cliente
                                                      as ClientesdiaLoaded;
                                              context.read<PedidosBloc>().add(
                                                  SavePedidoEvent(
                                                      codcli: esta
                                                          .cliente!.codcli));
                                            }
                                          },
                                          backgroundColor:
                                              Color.fromRGBO(2, 136, 31, 1))
                                      : Container())
                              : Container(),
                        ],
                      ),
                    ),
                    body: Container(
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
                                          label: Expanded(
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
        ));
  }

  List<DataRow> listado(List<PedidoLinea>? lineas) {
    List<DataRow> resultado = [];
    if (lineas == null) return [];
    for (int index = 0; index < lineas.length; index++) {
      PedidoLinea linea = lineas[index];

      double subtotal =
          linea.cantidad * linea.precio * (1 - (linea.descuento ?? 0) / 100);
      resultado.add(DataRow(
          cells: <DataCell>[
            DataCell(Text(linea.codart.toString())),
            DataCell(Text(linea.nombre ?? '')),
            DataCell(Text(linea.cantidad.toString())),
            DataCell(Text(linea.precio.toString())),
            DataCell(Text(linea.descuento.toString())),
            DataCell(Text(subtotal.toStringAsFixed(2))),
            DataCell(InkWell(
                onTap: () {
                  context.read<PedidosBloc>().add(DeleteLinea(index: index));
                },
                child: Container(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )))
          ],
          onSelectChanged: (value) => {
                if (value == true)
                  {
                    LineaPedido2Dialog.openDialogWithData(
                        context, GlobalConstants.findProducto(linea.codart)!,
                        index: int.parse(index.toString()),
                        cantidad: linea.cantidad)
                  }
              }));
    }

    return resultado;
  }
}
