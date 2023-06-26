part of 'pedidos_bloc.dart';

abstract class PedidosEvent extends Equatable {
  const PedidosEvent();

  @override
  List<Object> get props => [];
}

class InitPedidoBuild extends PedidosEvent {}

class PedidosAddLinea extends PedidosEvent {
  final int codart;
  final int cantidad;
  const PedidosAddLinea({required this.cantidad, required this.codart});
}

class SavePedidoEvent extends PedidosEvent {
  final int codcli;
  const SavePedidoEvent({required this.codcli});
}

class DeleteLinea extends PedidosEvent {
  final int index;

  const DeleteLinea({required this.index});
}

class GetPedidoCliente extends PedidosEvent {
  final int codcli;
  const GetPedidoCliente(this.codcli);
}

class PedidosUpdateLinea extends PedidosEvent {
  final Producto producto;
  final int cantidad;
  final int index;

  const PedidosUpdateLinea(
      {required this.cantidad, required this.producto, required this.index});
}
