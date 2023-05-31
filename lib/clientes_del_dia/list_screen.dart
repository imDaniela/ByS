import 'package:bys_app/clientes_del_dia/day_selector.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:bys_app/inicio_sesion/model/ClientesDia.dart';
import 'package:flutter/material.dart';
import 'package:bys_app/componentes_comunes/navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            alignment: Alignment.center,
                            child: const Text(
                              'Relación Cliente', // Add your label text here
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              width: 10000000,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                  cursorColor:
                                      const Color.fromRGBO(142, 11, 44, 1),
                                  decoration: InputDecoration(
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
                        context
                            .read<ClientesdiaBloc>()
                            .add(LoadClientesDia(dia: index));
                      },
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: DataTable(
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
                                      label: Expanded(
                                        child: Text(
                                          'Nombre fiscal',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: state is ClientesdiaLoaded
                                      ? listado(state.clientes)
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
          DataCell(Text(cliente.nom))
        ],
      ));
    });
    for (int i = 0; i < 100; i++) {}
    return resultado;
  }
}
