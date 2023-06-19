import 'package:bloc/bloc.dart';
import 'package:bys_app/pedidos/api/pedidos_api.dart';
import 'package:bys_app/pedidos/models/ClienteSaldoPendiente.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
part 'cobros_event.dart';
part 'cobros_state.dart';

class CobrosBloc extends Bloc<CobrosEvent, CobrosState> {
  CobrosBloc() : super(CobrosInitial()) {
    on<CheckDeudaEvent>((event, emit) async {
      emit(CobroLoading());

      http.Response? resp = await PedidosApi.Saldo(event.codcli);
      if (resp != null) {
        if (resp.statusCode == 200) {
          ClienteSaldoPendiente saldo =
              ClienteSaldoPendiente.fromJson(resp.body);
          if (saldo.deuda > 0) {
            print('object');
            emit(CobrosPendientes(saldo));
          }
        }
      }
    });
  }
}
