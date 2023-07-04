part of 'pedidos_dia_bloc.dart';

abstract class PedidosDiaEvent extends Equatable {
  const PedidosDiaEvent();

  @override
  List<Object> get props => [];
}

class LoadPedidosDia extends PedidosDiaEvent {
  DateTime? dia;
  LoadPedidosDia({this.dia});
}
