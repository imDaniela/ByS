part of 'clientesdia_bloc.dart';

abstract class ClientesdiaEvent extends Equatable {
  const ClientesdiaEvent();

  @override
  List<Object> get props => [];
}

class LoadClientesDia extends ClientesdiaEvent {
  int? dia;
  LoadClientesDia({this.dia});
}

class SelectClienteDia extends ClientesdiaEvent {
  ClientesDia cliente;
  SelectClienteDia(this.cliente);
}
