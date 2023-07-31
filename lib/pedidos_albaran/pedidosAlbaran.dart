import 'dart:async';

import 'package:bys_app/general/const.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:bys_app/pedidos_albaran/bloc/pedidos_albara_state.dart';
import 'package:bys_app/pedidos_albaran/bloc/pedidos_albaran_bloc.dart';
import 'package:bys_app/pedidos_albaran/bloc/pedidos_albaran_event.dart';
import 'package:bys_app/pedidos_albaran/models/pedidoAlbaranLinea.dart';
import 'package:bys_app/pedidos_albaran/pedidosAlbaranDetalles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PedidosAlbaranScreen extends StatelessWidget {
  const PedidosAlbaranScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _PedidosAlbaranScreen();
  }
}

class _PedidosAlbaranScreen extends StatefulWidget {
  const _PedidosAlbaranScreen({Key? key}) : super(key: key);

  @override
  State<_PedidosAlbaranScreen> createState() => _PedidosAlbaranScreenState();
}

class _PedidosAlbaranScreenState extends State<_PedidosAlbaranScreen> {
  // Search Controller
  TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
        (_) => context.read<PedidosAlbaranBloc>().add(SearchPedido()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PedidosAlbaranBloc, PedidosAlbaranState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state == const PedidoAlbaranBuilding()) {
          return BlocBuilder<ClientesdiaBloc, ClientesdiaState>(
              builder: (context, state_cliente) => Scaffold(
                      body: Container(
                          child: Column(
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.only(top: 60, bottom: 40),
                          child: _appBar()),
                      Expanded(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Container(
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
                                              'Codigo',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        // DataColumn(
                                        //   label: Expanded(
                                        //     child: Text(
                                        //       'Nombre Fiscal',
                                        //       style: TextStyle(
                                        //           fontStyle: FontStyle.italic,
                                        //           color: Colors.white),
                                        //     ),
                                        //   ),
                                        // ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Text(
                                              'Nombre Comercial',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Expanded(
                                            child: Text(
                                              'Fecha Creacion',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        // DataColumn(
                                        //   label: Expanded(
                                        //     child: Text(
                                        //       'Fecha Cobro',
                                        //       style: TextStyle(
                                        //           fontStyle: FontStyle.italic,
                                        //           color: Colors.white),
                                        //     ),
                                        //   ),
                                        // ),
                                        // DataColumn(
                                        //   label: Expanded(
                                        //     child: Text(
                                        //       'Importe',
                                        //       style: TextStyle(
                                        //           fontStyle: FontStyle.italic,
                                        //           color: Colors.white),
                                        //     ),
                                        //   ),
                                        // ),
                                        // DataColumn(
                                        //   label: Expanded(
                                        //     child: Text(
                                        //       'F.P',
                                        //       style: TextStyle(
                                        //           fontStyle: FontStyle.italic,
                                        //           color: Colors.white),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                      rows: state is PedidoAlbaranBuilding
                                          ? listado(state.lineas)
                                          : []),
                                ),
                              ))),
                    ],
                  ))));
        } else if (state is PedidoAlbaranLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _appBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.center,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Pedidos Albaran', // Add your label text here
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Container(
            width: 10000000,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
                controller: _searchController,
                onChanged: (val) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    // do something with query
                    context
                        .read<PedidosAlbaranBloc>()
                        .add(SearchPedido(query: val));
                  });
                },
                cursorColor: const Color.fromRGBO(142, 11, 44, 1),
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ), // Ícono antes del texto
                  filled: true, // Enable filling the TextField background
                  fillColor: const Color.fromRGBO(
                      212, 212, 212, 1), // Set the background color
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(142, 11, 44,
                            1)), // Set the border color when focused
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ))),
      ],
    );
  }

  List<DataRow> listado(List<PedidoAlbaranLinea>? lineas) {
    List<DataRow> resultado = [];
    if (lineas == null) return [];
    for (int index = 0; index < lineas.length; index++) {
      PedidoAlbaranLinea linea = lineas[index];
      resultado.add(DataRow(
          cells: <DataCell>[
            DataCell(Text(linea.numeroAlbaran.toString())),
            DataCell(Text(linea.nombreComercial ?? '')),
            DataCell(Text(GlobalConstants.format
                .format(DateTime.parse(linea.fechaCreacion.toString())))),
            // DataCell(Text(linea.precio.toString())),
            // DataCell(Text(linea.descuento.toString())),
            // DataCell(Text(subtotal.toStringAsFixed(2))),
          ],
          onSelectChanged: (value) => {
                if (value == true)
                  {
                    AlbaranDialogHelper.openDialogWithData(
                        context, linea.numeroAlbaran!)
                  }
              }));
    }

    return resultado;
  }
}
