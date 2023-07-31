import 'package:equatable/equatable.dart';

abstract class CobrosRealizadosEvent extends Equatable {
  const CobrosRealizadosEvent();

  @override
  List<Object> get props => [];
}

class CheckDeudaEvent extends CobrosRealizadosEvent {
  final int codcli;
  final bool showDialog;
  const CheckDeudaEvent(this.codcli, {this.showDialog = true});
}

class GetCobrosRealizados extends CobrosRealizadosEvent {
  final DateTime init;
  final DateTime end;
  final String? search;
  const GetCobrosRealizados({required this.init, required this.end, this.search});
}

class GetDetallesCobro extends CobrosRealizadosEvent {
  final int numeroFactura;
  const GetDetallesCobro({required this.numeroFactura});
}