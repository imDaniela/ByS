import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bys_app/productos/api/productos_api.dart';
import 'package:bys_app/productos/models/producto.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'productos_event.dart';
part 'productos_state.dart';

class ProductosBloc extends Bloc<ProductosEvent, ProductosState> {
  ProductosBloc() : super(ProductosInitial()) {
    on<LoadProductos>((event, emit) async {
      http.Response resp = await ProductosApi.getProductos();
      if (resp != null) {
        if (resp.statusCode == 200) {
          List<Producto> productos = [];
          List<dynamic> temp = jsonDecode(resp.body);
          temp.forEach((element) {
            productos.add(Producto.fromMap(element));
          });
          emit(ProductosInitial(productos: productos));
        }
      }
    });
  }
}
