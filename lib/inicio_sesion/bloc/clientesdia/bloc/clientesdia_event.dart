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
  int? codrep;
  LoadClientesDia({this.dia, this.search, this.codrep});
}

class SelectClienteDia extends ClientesdiaEvent {
  ClientesDia cliente;
  SelectClienteDia(this.cliente);
}

class AddClienteDiaEvent extends ClientesdiaEvent {
  int codcli;
  int dia;
  int tarde;
  AddClienteDiaEvent(
      {required this.codcli, required this.dia, required this.tarde});
}

class SelectClienteDiaById extends ClientesdiaEvent {
  int cliente;
  SelectClienteDiaById(this.cliente);
}
