import 'package:bloc/bloc.dart';
import 'package:bys_app/pedidos/api/pedidos_api.dart';
import 'package:bys_app/pedidos/models/ClienteSaldoPendiente.dart';
import 'package:bys_app/pedidos/models/PedidoLinea.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'pedidos_event.dart';
part 'pedidos_state.dart';

class PedidosBloc extends Bloc<PedidosEvent, PedidosState> {
  PedidosBloc() : super(PedidosInitial()) {
    on<InitPedidoBuild>((event, emit) async {
      emit(PedidoBuilding());
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
