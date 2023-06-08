part of 'pedidos_bloc.dart';

abstract class PedidosEvent extends Equatable {
  const PedidosEvent();

  @override
  List<Object> get props => [];
}

class InitPedidoBuild extends PedidosEvent {}

class CheckDeudaEvent extends PedidosEvent {
  final int codcli;
  const CheckDeudaEvent(this.codcli);
}
