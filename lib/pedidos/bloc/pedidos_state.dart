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

class PedidoBuilding extends PedidosState {
  final List<PedidoLinea> lineas;
  final Totales? totales;
  const PedidoBuilding({this.lineas = const [], this.totales}) : super();
}

class PedidosSuccess extends PedidosState {}

class PedidosInitial extends PedidosState {}
