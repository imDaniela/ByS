part of 'cliente_bloc.dart';

abstract class ClienteState extends Equatable {
  const ClienteState();

  @override
  List<Object> get props => [];
}

class ClienteInitial extends ClienteState {}

class ClienteLoading extends ClienteState {}

class ClienteError extends ClienteState {
  final String? msg;
  ClienteError({this.msg}) : super();
}

class ClienteLoaded extends ClienteState {
  final ClientesDia cliente;
  const ClienteLoaded(this.cliente) : super();
}
