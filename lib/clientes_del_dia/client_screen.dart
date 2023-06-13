import 'package:bys_app/clientes_del_dia/historial_cliente/bloc/history_bloc.dart';
import 'package:bys_app/clientes_del_dia/historial_cliente/model/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({Key? key}) : super(key: key);

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
  const ClienteHistorial({Key? key}) : super(key: key);

  @override
  State<ClienteHistorial> createState() => _ClienteHistorial();
}

class _ClienteHistorial extends State<ClienteHistorial> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(builder: (context, state) {
      if (state is HistoryLoaded) {
        context.read<HistoryBloc>();
        return Container(
            child: BlocBuilder<HistoryBloc, HistoryState>(
                builder: (context, state) => Column(
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
                                      ],
                                      rows: state is HistoryLoaded
                                          ? listado(state.historial)
                                          : []),
                                ))),
                      ],
                    )));
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
    historial.forEach((historial) {
      resultado.add(DataRow(
        cells: <DataCell>[
          DataCell(Text(historial.codcli.toString())),
          DataCell(Text(historial.codart.toString())),
          DataCell(Text(historial.desmod.toString())),
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text(historial.mes_1.toString())),
          DataCell(Text(historial.mes_2.toString())),
          DataCell(Text(historial.mes_3.toString())),
          DataCell(Text(historial.mes_4.toString())),
          DataCell(Text(historial.mes_5.toString())),
          DataCell(Text(historial.mes_6.toString())),
        ],
      ));
    });
    return resultado;
  }
}
