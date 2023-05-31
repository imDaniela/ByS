part of 'clientesdia_bloc.dart';

abstract class ClientesdiaState extends Equatable {
  const ClientesdiaState();

  @override
  List<Object> get props => [];
}

class ClientesdiaInitial extends ClientesdiaState {
  List<ClientesDia>? clientes;
  ClientesdiaInitial({this.clientes}) : super();
}

class ClientesdiaLoading extends ClientesdiaState {}

class ClientesdiaLoaded extends ClientesdiaState {
  List<ClientesDia>? clientes;
  ClientesdiaLoaded({this.clientes}) : super();
}
