import 'package:bys_app/cobros_unificados/cobros/models/cobro.dart';
import 'package:bys_app/pedidos/models/ClienteSaldoPendiente.dart';
import 'package:equatable/equatable.dart';

abstract class CobrosRealizadosState extends Equatable {
  const CobrosRealizadosState();

  @override
  List<Object> get props => [];
}

class CobrosRealizadosLoading extends CobrosRealizadosState {}

class CobrosRealizadosPendientes extends CobrosRealizadosState {
  final ClienteSaldoPendiente deuda;
  final bool showDialog;
  const CobrosRealizadosPendientes(this.deuda, {required this.showDialog})
      : super();
}

class CobrosRealizadosBuilding extends CobrosRealizadosState {
  final List<Cobro> cobros;
  final DateTime? inicio;
  final DateTime? fin;
  const CobrosRealizadosBuilding(this.cobros, {this.inicio, this.fin});
}

class CobrosRealizadosSuccess extends CobrosRealizadosState {}

class CobrosRealizadosInitial extends CobrosRealizadosState {}
