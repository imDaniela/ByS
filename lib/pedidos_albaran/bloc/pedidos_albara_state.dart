import 'package:bys_app/pedidos_albaran/models/pedidoAlbaranDetalles.dart';
import 'package:bys_app/pedidos_albaran/models/pedidoAlbaranLinea.dart';
import 'package:equatable/equatable.dart';

abstract class PedidosAlbaranState extends Equatable {
  final int? codcli;
  const PedidosAlbaranState({this.codcli});

  @override
  List<Object> get props => [];
}

class PedidoAlbaranLoading extends PedidosAlbaranState {}

class PedidosAlbaranError extends PedidosAlbaranState {
  final String? msg;
  const PedidosAlbaranError(this.msg) : super();
}

class PedidoAlbaranBuilding extends PedidosAlbaranState {
  final List<PedidoAlbaranLinea> lineas;
  const PedidoAlbaranBuilding({this.lineas = const []}) : super();
}

class PedidoAlbaranDetallesBuilding extends PedidosAlbaranState {
  final List<PedidoAlbaranDetalles> lineas;
  const PedidoAlbaranDetallesBuilding({this.lineas = const []}) : super();
}

class PedidosAlbaranSuccess extends PedidosAlbaranState {}

class PedidosAlbaranInitial extends PedidosAlbaranState {}
