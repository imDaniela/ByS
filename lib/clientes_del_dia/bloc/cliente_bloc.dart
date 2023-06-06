import 'package:bloc/bloc.dart';
import 'package:bys_app/inicio_sesion/model/ClientesDia.dart';
import 'package:equatable/equatable.dart';

part 'cliente_event.dart';
part 'cliente_state.dart';

class ClienteBloc extends Bloc<ClienteEvent, ClienteState> {
  ClienteBloc() : super(ClienteInitial()) {
    on<ClienteEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
