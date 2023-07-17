import 'package:equatable/equatable.dart';

abstract class PedidosAlbaranEvent extends Equatable {
  const PedidosAlbaranEvent();

  @override
  List<Object> get props => [];
}

class InitPedidoAlbaranBuild extends PedidosAlbaranEvent {}

class SearchPedido extends PedidosAlbaranEvent {
  final String? query;
  const SearchPedido({this.query});
}

class GetPedidoAlbaran extends PedidosAlbaranEvent {
  final int numeroAlbaran;
  const GetPedidoAlbaran({required this.numeroAlbaran});
}