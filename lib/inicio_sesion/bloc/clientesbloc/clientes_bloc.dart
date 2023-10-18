import 'package:bloc/bloc.dart';
import 'package:bys_app/inicio_sesion/api/clientes_dia_api.dart';
import 'package:bys_app/inicio_sesion/model/ClientesDia.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
part 'clientes_event.dart';
part 'clientes_state.dart';

class ClientesBloc extends Bloc<ClientesEvent, ClientesState> {
  ClientesBloc() : super(ClientesLoading()) {
    on<LoadAllClientes>((event, emit) async {
      http.Response resp = await ClientesDiaApi.getAllClientes();
      if (resp.statusCode == 200) {
        List<ClientesDia>? clientes = ClientesDia.fromJsonList(resp.body);
        if (clientes != null) emit(ClientesLoaded(clientes));
      }
    });
  }
}
