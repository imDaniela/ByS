import 'package:bloc/bloc.dart';
import 'package:bys_app/pedidos/pedidos_dia/api/pedidos_dia_api.dart';
import 'package:bys_app/pedidos/pedidos_dia/model/PedidoDia.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'pedidos_dia_event.dart';
part 'pedidos_dia_state.dart';

class PedidosDiaBloc extends Bloc<PedidosDiaEvent, PedidosDiaState> {
  PedidosDiaBloc() : super(PedidosDiaInitial()) {
    on<LoadPedidosDia>((event, emit) async {
      emit(PedidosDiaInitial());
      http.Response resp = await PedidosDiaApi.getProductos();
      if (resp.statusCode == 200) {
        List<PedidoDia>? pedidos = PedidoDia.fromJsonList(resp.body);
        if (pedidos != null) {
          emit(PedidosDiaLoaded(pedidos));
        }
      }
    });
  }
}
