part of 'pedidos_bloc.dart';

abstract class PedidosEvent extends Equatable {
  const PedidosEvent();

  @override
  List<Object> get props => [];
}

class InitPedidoBuild extends PedidosEvent {}

class PedidosAddLinea extends PedidosEvent {
  final Producto producto;
  final int cantidad;
  const PedidosAddLinea({required this.cantidad, required this.producto});
}

class PedidosUpdateLinea extends PedidosEvent {
  final Producto producto;
  final int cantidad;
  final int index;

  const PedidosUpdateLinea(
      {required this.cantidad, required this.producto, required this.index});
}

class CheckDeudaEvent extends PedidosEvent {
  final int codcli;
  const CheckDeudaEvent(this.codcli);
}
