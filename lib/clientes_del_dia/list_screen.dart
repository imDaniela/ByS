import 'package:bys_app/clientes_del_dia/day_selector.dart';
import 'package:bys_app/clientes_del_dia/historial_cliente/bloc/history_bloc.dart';
import 'package:bys_app/clientes_del_dia/saveAlertadialog.dart';
import 'package:bys_app/cobros/bloc/cobros_bloc.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:bys_app/inicio_sesion/model/ClientesDia.dart';
import 'package:bys_app/pedidos/bloc/pedidos_bloc.dart';
import 'package:bys_app/productos/bloc/productos_bloc.dart';
import 'package:bys_app/albaran_pendiente_por_facturar/bloc/albaran_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class DayScreen extends StatelessWidget {
  const DayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //bottomNavigationBar: NavigationBar(),
      body: Center(
        child: ListScreen(),
      ),
    );
  }
}

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreen();
}

class _ListScreen extends State<ListScreen> {
  TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: BlocBuilder<ClientesdiaBloc, ClientesdiaState>(
            builder: (context, state) => Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 60, bottom: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Container(
                                        child: Center(
                                            child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            500),
                                                    color: Color.fromRGBO(
                                                        142, 11, 44, 1)),
                                                child: InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              'pedidos_dia');
                                                    },
                                                    child: Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.white,
                                                    )))))),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Relación Cliente', // Add your label text here
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Container(
                                        child: Center(
                                            child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            500),
                                                    color: Color.fromRGBO(
                                                        142, 11, 44, 1)),
                                                child: InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pushNamed('alertas');
                                                    },
                                                    child: Icon(
                                                      Icons.alarm,
                                                      color: Colors.white,
                                                    ))))))
                              ],
                            ),
                          ),
                          Container(
                              width: 10000000,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                  controller: _controller,
                                  onChanged: (val) {
                                    if (_debounce?.isActive ?? false)
                                      _debounce!.cancel();
                                    _debounce = Timer(
                                        const Duration(milliseconds: 500), () {
                                      // do something with query
                                      context
                                          .read<ClientesdiaBloc>()
                                          .add(SearchCliente(val));
                                    });
                                  },
                                  cursorColor:
                                      const Color.fromRGBO(142, 11, 44, 1),
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
                                    filled:
                                        true, // Enable filling the TextField background
                                    fillColor: const Color.fromRGBO(212, 212,
                                        212, 1), // Set the background color
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromRGBO(142, 11, 44,
                                              1)), // Set the border color when focused
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                    DaySelector(
                      onChanged: (index) {
                        context.read<ClientesdiaBloc>().add(LoadClientesDia(
                            dia: index, search: _controller.text));
                      },
                    ),
                    Expanded(
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
                                          'Nombre comercial',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text(
                                          'Ord',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text(
                                          'Am-Pm',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text(
                                          'Rep',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: SizedBox(
                                        child: Text(
                                          'Nombre fiscal',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: SizedBox(
                                        child: Text(
                                          'Accion',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: state is ClientesdiaLoaded
                                      ? listado(_controller.text != ''
                                          ? state.clientes
                                          : state.clientes_all)
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

  List<DataRow> listado(List<ClientesDia>? clientes) {
    List<DataRow> resultado = [];
    if (clientes == null) return [];
    clientes.forEach((cliente) {
      resultado.add(DataRow(
          cells: <DataCell>[
            DataCell(Text(cliente.codcli.toString())),
            DataCell(Text(cliente.cal2)),
            DataCell(Text(cliente.ordenvisit)),
            DataCell(Text(cliente.ampm)),
            DataCell(Text('')),
            DataCell(Text(cliente.nom)),
            DataCell(Container(
                child: InkWell(
              onTap: () {
                SaveAlertaDialog.openDialogWithData(context, cliente: cliente);
              },
              child: Icon(Icons.alarm),
            )))
          ],
          onSelectChanged: (bool? selected) {
            if (selected != null && selected) {
              context.read<ClientesdiaBloc>().add(SelectClienteDia(cliente));
              context.read<CobrosBloc>().add(CheckDeudaEvent(cliente.codcli));
              context.read<ProductosBloc>().add(LoadProductos(cliente.codcli));
              context.read<PedidosBloc>().add(GetPedidoCliente(cliente.codcli));

              context
                  .read<HistoryBloc>()
                  .add(LoadHistory(codcli: cliente.codcli));
              Navigator.of(context).pushNamed('zona_clientes');
              context
                  .read<AlbaranBloc>()
                  .add(LoadAlbaran(codcli: cliente.codcli));
            }
          }));
    });
    return resultado;
  }
}
