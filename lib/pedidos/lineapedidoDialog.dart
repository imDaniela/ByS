import 'package:bys_app/pedidos/bloc/pedidos_bloc.dart';
import 'package:bys_app/productos/bloc/productos_bloc.dart';
import 'package:bys_app/productos/models/producto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LineaPedidoDialog {
  static void openDialogWithData(BuildContext context) {
    List<DataRow> elementos(List<Producto> detalles) {
      List<DataRow> result = [];
      detalles.forEach((element) {
        result.add(DataRow(cells: [
          DataCell(Text(element.codart.toString())),
          DataCell(Text(element.des)),
          DataCell(Text(element.sto.toString())),
        ]));
      });
      return result;
    }

    TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          clipBehavior: Clip.antiAlias,
          titlePadding: EdgeInsets.all(0),
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Text(
              'Agregar Articulos',
              style: TextStyle(color: Colors.white),
            ),
            color: Color.fromRGBO(142, 11, 44, 1),
          ),
          content: Column(
            children: [
              Container(
                  width: 10000000,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        context
                            .read<ProductosBloc>()
                            .add(SearchProductos(value));
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
              Expanded(
                  child: Container(
                      width: 1000000,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: BlocBuilder<ProductosBloc, ProductosState>(
                            builder: (context, state) => PaginatedDataTable(
                              availableRowsPerPage: [5],
                              showCheckboxColumn: false,
                              // Optional: Add a header for the table
                              columns: [
                                DataColumn(label: Text('Cod. Art.')),
                                DataColumn(label: Text('Descripción')),
                                DataColumn(label: Text('Stock')),
                              ],
                              source: _ProductosDataSource(
                                  _controller.text == ''
                                      ? state.productos
                                      : state.productos,
                                  context), // Create a custom DataTableSource
                              // Add any additional properties and customization as per your requirements
                            ),
                          )))),
            ],
          ),
          actions: [],
        );
      },
    );
  }
}

class LineaPedido2Dialog {
  static void openDialogWithData(BuildContext context, Producto producto,
      {int? index, int? cantidad}) {
    TextEditingController _controller = TextEditingController();
    _controller.text = "1";
    if (cantidad != null) _controller.text = cantidad.toString();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          clipBehavior: Clip.antiAlias,
          titlePadding: EdgeInsets.all(0),
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Text(
              'Agregar Articulos',
              style: TextStyle(color: Colors.white),
            ),
            color: Color.fromRGBO(142, 11, 44, 1),
          ),
          content: Container(
              width: 1000000,
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text('Producto:')),
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(producto.des)),
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text('Precio:')),
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(producto.prevena.toString())),
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text('Stock:')),
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(producto.sto.toString())),
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text('Cantidad:')),
                  Container(
                      width: 10000000,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _controller,
                          cursorColor: const Color.fromRGBO(142, 11, 44, 1),
                          decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50.0),
                            ),

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
              ))),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(142, 11, 44, 1)),
              child: Text('Agregar'),
              onPressed: () {
                if (index == null) {
                  context.read<PedidosBloc>().add(PedidosAddLinea(
                      cantidad: int.parse(_controller.text),
                      codart: producto.codart));
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                } else {
                  context.read<PedidosBloc>().add(PedidosUpdateLinea(
                      index: index,
                      cantidad: int.parse(_controller.text),
                      producto: producto));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class _ProductosDataSource extends DataTableSource {
  final List<Producto> productos;
  final BuildContext context;

  _ProductosDataSource(this.productos, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= productos.length) {
      return null; // Return null for indices that exceed the data length
    }
    TextStyle estilo = const TextStyle(fontSize: 10);
    final producto = productos[index];
    return DataRow(
        cells: [
          DataCell(Text(producto.codart.toString(), style: estilo)),
          DataCell(Text(producto.des, style: estilo)),
          DataCell(Text(producto.sto.toString(), style: estilo)),
        ],
        onSelectChanged: (bool? selected) {
          if (selected != null && selected) {
            LineaPedido2Dialog.openDialogWithData(context, producto);
          }
        });
  }

  @override
  int get rowCount => productos.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
