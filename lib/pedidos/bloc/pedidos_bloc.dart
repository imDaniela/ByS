import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bys_app/general/const.dart';
import 'package:bys_app/pedidos/api/pedidos_api.dart';
import 'package:bys_app/pedidos/models/PedidoLinea.dart';
import 'package:bys_app/productos/models/producto.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'pedidos_event.dart';
part 'pedidos_state.dart';

class PedidosBloc extends Bloc<PedidosEvent, PedidosState> {
  PedidosBloc() : super(PedidosInitial()) {
    on<InitPedidoBuild>((event, emit) async {
      emit(PedidoBuilding());
    });
    on<PedidosAddLinea>((event, emit) async {
      List<PedidoLinea> lineas;

      if (state is PedidoBuilding) {
        lineas = (state as PedidoBuilding).lineas.toList();
      } else {
        lineas = [];
      }
      emit(PedidoLoading());
      Producto? producto = GlobalConstants.findProducto(event.codart);

      if (producto != null) {
        lineas.add(PedidoLinea(
            codart: event.codart,
            cantidad: event.cantidad,
            nombre: producto.des,
            precio: producto.prevena,
            sto: producto.sto,
            descuento: producto.desc));
      }
      emit(PedidoBuilding(lineas: lineas));
      if (producto?.rel != null) {
        Producto? producto_rel = GlobalConstants.findProducto(producto!.rel!);
        if (producto_rel != null) {
          addRel(producto.rel!, event.cantidad);
        }
      }
    });
    on<DeleteLinea>((event, emit) async {
      if (state is PedidoBuilding) {
        List<PedidoLinea> lineas = (state as PedidoBuilding).lineas;
        emit(PedidoLoading());
        int codart = lineas[event.index].codart;
        int canped = lineas[event.index].cantidad;
        lineas.removeAt(event.index);
        emit(PedidoBuilding(lineas: lineas));
        Producto? producto = GlobalConstants.findProducto(codart);
        if (producto?.rel != null) {
          Producto? producto_rel = GlobalConstants.findProducto(producto!.rel!);
          if (producto_rel != null) {
            addRel(producto.rel!, -canped);
          }
        }
      }
    });
    on<GetPedidoCliente>((event, emit) async {
      List<PedidoLinea> lineas = [];
      emit(PedidoLoading());
      // try {
      http.Response resp = await PedidosApi.gePedido(event.codcli);
      if (resp.statusCode == 200) {
        if (resp.body != 'null') {
          List<dynamic> _temp = jsonDecode(resp.body)['temppedclilis'];

          _temp.forEach((element) {
            PedidoLinea linea = PedidoLinea.fromMap(element);
            lineas.add(linea);
          });
        }
      }
      //} catch (exception) {}
      emit(PedidoBuilding(lineas: lineas));
    });
    on<SavePedidoEvent>((event, emit) async {
      if (state is PedidoBuilding) {
        PedidoBuilding estado = state as PedidoBuilding;
        if (estado.lineas.length > 0) {
          try {
            PedidosApi.SavePedido(event.codcli, estado.lineas);
            emit(PedidosSuccess());
            emit(estado);
          } catch (exception) {}
        }
      }
    });

    on<PedidosUpdateLinea>((event, emit) async {
      List<PedidoLinea> lineas;

      if (state is PedidoBuilding) {
        lineas = (state as PedidoBuilding).lineas;
        emit(PedidoLoading());
        int mount = (event.cantidad - lineas[event.index].cantidad);
        lineas[event.index] = (PedidoLinea(
            codart: event.producto.codart,
            cantidad: event.cantidad,
            nombre: event.producto.des,
            precio: event.producto.prevena,
            descuento: event.producto.desc,
            sto: event.producto.sto));
        emit(PedidoBuilding(lineas: lineas));
        Producto? producto =
            GlobalConstants.findProducto(event.producto.codart);
        if (producto?.rel != null) {
          Producto? producto_rel = GlobalConstants.findProducto(producto!.rel!);
          if (producto_rel != null) {
            addRel(producto.rel!, mount);
          }
        }
      }
    });
  }
  void addRel(int rel, int amount) {
    List<PedidoLinea> lineas;
    if (state is PedidoBuilding) {
      lineas = (state as PedidoBuilding).lineas.toList();
      int index = lineas.indexWhere((element) {
        return element.codart == rel;
      });
      if (index < 0) {
        add(PedidosAddLinea(cantidad: amount, codart: rel));
      } else {
        PedidoLinea linea = lineas[index];

        if ((linea.cantidad + amount) <= 0) {
          add(DeleteLinea(index: index));
        } else {
          Producto? producto = GlobalConstants.findProducto(rel);
          add(PedidosUpdateLinea(
              index: index,
              cantidad: linea.cantidad + amount,
              producto: producto!));
        }
      }
    }
  }
}
