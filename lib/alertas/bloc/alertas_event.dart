part of 'alertas_bloc.dart';

abstract class AlertasEvent extends Equatable {
  const AlertasEvent();

  @override
  List<Object> get props => [];
}

class LoadAlertas extends AlertasEvent {}

class SaveAlerta extends AlertasEvent {
  final int? id;
  final int codcli;
  final String descripcion;
  final DateTime fecha;
  final String cliente;
  const SaveAlerta(
      {this.id,
      required this.codcli,
      required this.descripcion,
      required this.fecha,
      required this.cliente});
}

class deleteAlertas extends AlertasEvent {
  final int id;
  const deleteAlertas(this.id);
}
