import 'package:bys_app/albaran_pendiente_por_facturar/bloc/albaran_bloc.dart';
import 'package:bys_app/albaran_pendiente_por_facturar/model/albaran.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbaranScreen extends StatelessWidget {
  const AlbaranScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: AlbaranPendientePorFacturar(),
      ),
    );
  }
}

class AlbaranPendientePorFacturar extends StatefulWidget {
  const AlbaranPendientePorFacturar({Key? key}) : super(key: key);

  @override
  State<AlbaranPendientePorFacturar> createState() =>
      _AlbaranPendientePorFacturar();
}

class _AlbaranPendientePorFacturar extends State<AlbaranPendientePorFacturar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbaranBloc, AlbaranState>(builder: (context, state) {
      if (state is AlbaranLoaded) {
        context.read<AlbaranBloc>();
        return Container(
            child: BlocBuilder<AlbaranBloc, AlbaranState>(
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
                                              'Albarán',
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
                                              '%Dto.',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Text(
                                              'Subtotal',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: state is AlbaranLoaded
                                          ? listado(state.albaranes)
                                          : []),
                                ))),
                      ],
                    )));
      } else if (state is AlbaranLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return SizedBox.shrink();
      }
    });
  }

  List<DataRow> listado(List<Albaran>? albaranes) {
    List<DataRow> resultado = [];
    if (albaranes == null) return [];
    albaranes.forEach((albaran) {
      resultado.add(DataRow(
        cells: <DataCell>[
          DataCell(Text(albaran.numalb.toString())),
          DataCell(Text(albaran.codart.toString())),
          DataCell(Text(albaran.desmod.toString())),
          DataCell(Text(albaran.canser.toString())),
          DataCell(Text(albaran.preven.toString())),
          DataCell(Text(albaran.tandto.toString())),
          DataCell(Text(albaran.subtot.toString())),
        ],
      ));
    });
    return resultado;
  }
}
