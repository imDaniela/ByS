import 'package:bys_app/clientes_del_dia/historial_cliente/bloc/history_bloc.dart';
import 'package:bys_app/clientes_del_dia/historial_cliente/model/history.dart';
import 'package:bys_app/pedidos/bloc/pedidos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: NavigationBar(),
      appBar: AppBar(),
      body: Center(
        child: ClienteHistorial(),
      ),
    );
  }
}

class ClienteHistorial extends StatefulWidget {
  final TabController? tabcontroller;

  const ClienteHistorial({Key? key, this.tabcontroller}) : super(key: key);

  @override
  State<ClienteHistorial> createState() => _ClienteHistorial();
}

class _ClienteHistorial extends State<ClienteHistorial> {
  List<Historial> elementos = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(builder: (context, state) {
      if (state is HistoryLoaded) {
        context.read<HistoryBloc>();
        return Container(
            child: BlocBuilder<HistoryBloc, HistoryState>(
                builder: (context, state) => Scaffold(
                    floatingActionButton: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            FloatingActionButton(
                                child: Icon(Icons.add),
                                onPressed: () {
                                  elementos.forEach((element) {
                                    context.read<PedidosBloc>().add(
                                        PedidosAddLinea(
                                            cantidad: element.canped ?? 0,
                                            codart: element.codart));
                                  });
                                  if (widget.tabcontroller != null) {
                                    widget.tabcontroller!.animateTo(0);
                                  }
                                },
                                backgroundColor:
                                    Color.fromRGBO(142, 11, 44, 1)),
                            SizedBox(
                              height: 20,
                            ),
                            state is HistoryStateInitial
                                ? Container(
                                    child: state.historial.length > 0
                                        ? FloatingActionButton(
                                            child: Icon(Icons.save),
                                            onPressed: () {
                                              // if (state is HistoryLoaded) {
                                              //   HistoryLoaded esta =
                                              //       state as HistoryLoaded;
                                              //   context.read<HistoryBloc>().add(
                                              //       SavePedidoEvent(
                                              //           codcli: esta
                                              //               .cliente!.codcli));
                                              // }
                                            },
                                            backgroundColor:
                                                Color.fromRGBO(2, 136, 31, 1))
                                        : Container())
                                : Container(),
                          ]),
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
                                        headingRowColor: MaterialStateProperty
                                            .resolveWith<Color>((states) =>
                                                const Color.fromRGBO(
                                                    142, 11, 44, 1)),
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
                                          DataColumn(
                                            label: Expanded(
                                              child: Text(
                                                'Mes 7',
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Expanded(
                                              child: Text(
                                                'Mes 8',
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Expanded(
                                              child: Text(
                                                'Mes 9',
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Expanded(
                                              child: Text(
                                                'Mes 10',
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Expanded(
                                              child: Text(
                                                'Mes 11',
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Expanded(
                                              child: Text(
                                                'Mes 12',
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                        rows: state is HistoryLoaded
                                            ? listado(state.historial)
                                            : []),
                                  ))),
                        ],
                      ),
                    ))));
      } else if (state is HistoryLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return SizedBox.shrink();
      }
    });
  }

  List<DataRow> listado(List<Historial>? historial) {
    List<DataRow> resultado = [];
    if (historial == null) return [];
    num total_year = 0;
    historial.forEach((historial) {
      total_year = historial.mes_1 +
          historial.mes_2 +
          historial.mes_3 +
          historial.mes_4 +
          historial.mes_5 +
          historial.mes_6 +
          historial.mes_7 +
          historial.mes_8 +
          historial.mes_9 +
          historial.mes_10 +
          historial.mes_11 +
          historial.mes_12;
      resultado.add(DataRow(
        cells: <DataCell>[
          DataCell(Text(historial.codcli.toString())),
          DataCell(Text(historial.codart.toString())),
          DataCell(Text(historial.desmod.toString())),
          DataCell(TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value.isNotEmpty && !isNumeric(value)) {
                // Remove non-numeric characters from the input
                setState(() {
                  value = value.replaceAll(RegExp('[^0-9]'), '');
                });
              } else {
                int index = elementos.indexWhere(
                    (element) => element.codart == historial.codart);
                historial.canped = int.tryParse(value) ?? 0;
                if (index >= 0) {
                  if (historial.canped == 0) {
                    elementos.removeAt(index);
                  } else {
                    elementos[index] = historial;
                  }
                } else {
                  elementos.add(historial);
                }
              }
            },
            decoration: InputDecoration(hintText: '0'),
          )),
          DataCell(Text(total_year.toString())),
          DataCell(Text(historial.mes_1.toString())),
          DataCell(Text(historial.mes_2.toString())),
          DataCell(Text(historial.mes_3.toString())),
          DataCell(Text(historial.mes_4.toString())),
          DataCell(Text(historial.mes_5.toString())),
          DataCell(Text(historial.mes_6.toString())),
          DataCell(Text(historial.mes_7.toString())),
          DataCell(Text(historial.mes_8.toString())),
          DataCell(Text(historial.mes_9.toString())),
          DataCell(Text(historial.mes_10.toString())),
          DataCell(Text(historial.mes_11.toString())),
          DataCell(Text(historial.mes_12.toString())),
        ],
      ));
    });
    return resultado;
  }

  bool isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }
}
