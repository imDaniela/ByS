part of 'clientesdia_bloc.dart';

abstract class ClientesdiaEvent extends Equatable {
  const ClientesdiaEvent();

  @override
  List<Object> get props => [];
}

class SearchCliente extends ClientesdiaEvent {
  final String search;
  const SearchCliente(this.search);
}

class LoadClientesDia extends ClientesdiaEvent {
  int? dia;
  String? search;
  LoadClientesDia({this.dia, this.search});
}

class SelectClienteDia extends ClientesdiaEvent {
  ClientesDia cliente;
  SelectClienteDia(this.cliente);
}
class SelectClienteDiaById extends ClientesdiaEvent {
  int cliente;
  SelectClienteDiaById(this.cliente);
}