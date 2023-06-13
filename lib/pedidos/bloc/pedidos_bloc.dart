import 'package:bloc/bloc.dart';
import 'package:bys_app/general/const.dart';
import 'package:bys_app/pedidos/api/pedidos_api.dart';
import 'package:bys_app/pedidos/models/ClienteSaldoPendiente.dart';
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

      print(lineas);
      emit(PedidoBuilding(lineas: lineas));
    });
    on<DeleteLinea>((event, emit) async {
      if (state is PedidoBuilding) {
        List<PedidoLinea> lineas = (state as PedidoBuilding).lineas;
        emit(PedidoLoading());
        lineas.removeAt(event.index);
        emit(PedidoBuilding(lineas: lineas));
      }
    });

    on<PedidosUpdateLinea>((event, emit) async {
      List<PedidoLinea> lineas;

      if (state is PedidoBuilding) {
        lineas = (state as PedidoBuilding).lineas;
        emit(PedidoLoading());
        lineas[event.index] = (PedidoLinea(
            codart: event.producto.codart,
            cantidad: event.cantidad,
            nombre: event.producto.des,
            precio: event.producto.prevena,
            descuento: event.producto.desc,
            sto: event.producto.sto));
        print(lineas);
        emit(PedidoBuilding(lineas: lineas));
      }
    });

    on<CheckDeudaEvent>((event, emit) async {
      emit(PedidoLoading());

      http.Response? resp = await PedidosApi.Saldo(event.codcli);
      if (resp != null) {
        if (resp.statusCode == 200) {
          ClienteSaldoPendiente saldo =
              ClienteSaldoPendiente.fromJson(resp.body);
          if (saldo.deuda > 0) {
            print('object');
            emit(PedidosDeuda(saldo));
          }
        }
      }
    });
  }
}
