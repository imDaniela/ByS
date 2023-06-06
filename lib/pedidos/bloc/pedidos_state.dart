part of 'pedidos_bloc.dart';

abstract class PedidosState extends Equatable {
  final int? codcli;
  const PedidosState({this.codcli});

  @override
  List<Object> get props => [];
}

class PedidoLoading extends PedidosState {}

class PedidosError extends PedidosState {
  final String? msg;
  const PedidosError(this.msg) : super();
}

class PedidosDeuda extends PedidosState {
  final ClienteSaldoPendiente deuda;
  const PedidosDeuda(this.deuda) : super();
}

class PedidosInitial extends PedidosState {}
