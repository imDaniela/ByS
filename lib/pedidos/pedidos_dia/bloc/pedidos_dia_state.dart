part of 'pedidos_dia_bloc.dart';

abstract class PedidosDiaState extends Equatable {
  const PedidosDiaState();

  @override
  List<Object> get props => [];
}

class PedidosDiaLoaded extends PedidosDiaState {
  List<PedidoDia> pedidos;
  PedidosDiaLoaded(this.pedidos);
}

class PedidosDiaInitial extends PedidosDiaState {}
