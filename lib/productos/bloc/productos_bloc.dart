import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bys_app/general/const.dart';
import 'package:bys_app/productos/api/productos_api.dart';
import 'package:bys_app/productos/models/producto.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'productos_event.dart';
part 'productos_state.dart';

class ProductosBloc extends Bloc<ProductosEvent, ProductosState> {
  ProductosBloc() : super(ProductosInitial()) {
    on<LoadProductos>((event, emit) async {
      http.Response resp = await ProductosApi.getProductos(event.codcli);
      if (resp.statusCode == 200) {
        List<Producto> productos = [];
        List<dynamic> temp = jsonDecode(resp.body);
        temp.forEach((element) {
          productos.add(Producto.fromMap(element));
        });
        GlobalConstants.productos = productos;
        emit(
            ProductosInitial(productos: productos, productos_all: productos));
      }
    });
    on<SearchProductos>((event, emit) {
      if (state is ProductosInitial) {
        ProductosInitial estado = state as ProductosInitial;
        emit(ProductosLoading());
        if (event.search == '') {
          emit(ProductosInitial(
              productos: estado.productos_all,
              productos_all: estado.productos_all));
        } else {
          List<Producto> productos = estado.productos_all.toList();
          productos.removeWhere((element) =>
              element.des.toUpperCase().contains(event.search.toUpperCase()) ==
              false);
          emit(ProductosInitial(
              productos: productos, productos_all: estado.productos_all));
        }
      }
    });
  }
}
