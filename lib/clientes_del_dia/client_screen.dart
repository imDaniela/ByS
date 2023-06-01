import 'package:flutter/material.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({Key? key}) : super(key: key);

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
        child: Column(
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
                      'Nombre Cliente', // Add your label text here
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      width: 10000000,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                          cursorColor: const Color.fromRGBO(142, 11, 44, 1),
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
              ),
            ),
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
        ));
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
