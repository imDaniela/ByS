import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bys_app/general/const.dart';
import 'package:bys_app/pedidos/api/pedidos_api.dart';
import 'package:bys_app/pedidos/models/PedidoLinea.dart';
import 'package:bys_app/pedidos/models/Totales.dart';
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
      Totales totales = Totales(iva: 0, totped: 0, subtotal: 0);
      if (state is PedidoBuilding) {
        lineas = (state as PedidoBuilding).lineas.toList();
        totales = (state as PedidoBuilding).totales ??
            Totales(iva: 0, totped: 0, subtotal: 0);
      } else {
        lineas = [];
      }
      emit(PedidoLoading());
      Producto? producto = GlobalConstants.findProducto(event.codart);

      if (producto != null) {
        PedidoLinea? linea_found;
        lineas.forEach((element) {
          if (element.codart == event.codart) {
            linea_found = element;
          }
        });
        if (linea_found != null) {
          linea_found!.cantidad += event.cantidad;
        } else {
          lineas.add(PedidoLinea(
              codart: event.codart,
              cantidad: event.cantidad,
              nombre: producto.des,
              precio: producto.prevena,
              sto: producto.sto,
              descuento: producto.desc,
              envase: producto.envase));
        }
      }
      lineas = sortLineas(lineas);

      emit(PedidoBuilding(lineas: lineas, totales: totales));
      if (producto?.rel != null) {
        Producto? producto_rel = GlobalConstants.findProducto(producto!.rel!);
        if (producto_rel != null) {
          addRel(producto.rel!, event.cantidad);
        }
      }
    });
    on<DeleteLinea>((event, emit) async {
      if (state is PedidoBuilding) {
        PedidoBuilding estado = state as PedidoBuilding;
        List<PedidoLinea> lineas = estado.lineas;
        emit(PedidoLoading());
        String codart = lineas[event.index].codart;
        int canped = lineas[event.index].cantidad;
        lineas.removeAt(event.index);
        lineas = sortLineas(lineas);

        emit(PedidoBuilding(lineas: lineas, totales: estado.totales));
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
      Totales totales = Totales(iva: 0, totped: 0, subtotal: 0);
      emit(PedidoLoading());
      // try {
      http.Response resp = await PedidosApi.gePedido(event.codcli);
      print(resp.statusCode);
      if (resp.statusCode == 200) {
        if (resp.body != 'null') {
          List<dynamic> _temp = jsonDecode(resp.body)['temppedclilis'];
          if (jsonDecode(resp.body)['temppedclica'] != null) {
            totales = Totales.fromMap(jsonDecode(resp.body)['temppedclica']);
            print(totales);
          }

          _temp.forEach((element) {
            PedidoLinea linea = PedidoLinea.fromMap(element);
            lineas.add(linea);
          });
        }
      }
      //} catch (exception) {}
      lineas = sortLineas(lineas);

      emit(PedidoBuilding(lineas: lineas, totales: totales));
    });
    on<SavePedidoEvent>((event, emit) async {
      if (state is PedidoBuilding) {
        PedidoBuilding estado = state as PedidoBuilding;
        List<PedidoLinea> lineas = sortLineas(estado.lineas);
        try {
          await PedidosApi.SavePedido(event.codcli, lineas,
              observaciones: event.observaciones, intobs: event.intobs);
          emit(PedidosSuccess());
          emit(estado);
          add(GetPedidoCliente(event.codcli));
        } catch (exception) {}
      }
    });

    on<PedidosUpdateLinea>((event, emit) async {
      List<PedidoLinea> lineas;

      if (state is PedidoBuilding) {
        PedidoBuilding estado = state as PedidoBuilding;
        lineas = estado.lineas;
        emit(PedidoLoading());
        int mount = (event.cantidad - lineas[event.index].cantidad);
        lineas[event.index] = (PedidoLinea(
            codart: event.producto.codart,
            cantidad: event.cantidad,
            nombre: event.producto.des,
            precio: event.producto.prevena,
            descuento: event.producto.desc,
            sto: event.producto.sto,
            envase: event.producto.envase));
        lineas = sortLineas(lineas);
        emit(PedidoBuilding(lineas: lineas, totales: estado.totales));
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
  List<PedidoLinea> sortLineas(List<PedidoLinea> _lineas) {
    List<PedidoLinea> lineas = [];
    _lineas.forEach((element) {
      lineas.add(element);
    });
    lineas.sort((a, b) {
      if (a.envase && !b.envase) {
        return 1; // a comes after b
      }
      if (!a.envase && b.envase) {
        return -1; // a comes before b
      }
      return 0; // a and b are equal in terms of sorting
    });
    return lineas;
  }

  void addRel(String rel, int amount) {
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
