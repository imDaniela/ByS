import 'package:bloc/bloc.dart';
import 'package:bys_app/inicio_sesion/api/clientes_dia_api.dart';
import 'package:bys_app/inicio_sesion/model/ClientesDia.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'clientesdia_event.dart';
part 'clientesdia_state.dart';

class ClientesdiaBloc extends Bloc<ClientesdiaEvent, ClientesdiaState> {
  ClientesdiaBloc() : super(ClientesdiaInitial()) {
    on<LoadClientesDia>((event, emit) async {
      if (event.dia != null) {
        emit(ClientesdiaLoading());
        http.Response? resp = await ClientesDiaApi.GetClientesDia(event.dia!);
        if (resp != null) {
          if (resp.statusCode == 200) {
            List<ClientesDia>? clientes = ClientesDia.fromJsonList(resp.body);
            print(clientes);
            if (clientes != null) {
              emit(ClientesdiaLoaded(clientes: clientes));
            }
          }
        }
      }
    });
  }
}
