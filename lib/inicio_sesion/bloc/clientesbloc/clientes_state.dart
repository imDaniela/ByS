part of 'clientes_bloc.dart';

class ClientesState extends Equatable {
  const ClientesState();

  @override
  List<Object> get props => [];
}

class ClientesLoading extends ClientesState {}

class ClientesLoaded extends ClientesState {
  List<ClientesDia> clientes;
  ClientesLoaded(this.clientes);
}
