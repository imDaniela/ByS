import 'package:bys_app/cobros_unificados/cobros_pendientes/models/cobro_pendiente.dart';
import 'package:equatable/equatable.dart';

abstract class CobrosPendientesState extends Equatable {
  const CobrosPendientesState();

  @override
  List<Object> get props => [];
}

class CobrosPedientesBuilding extends CobrosPendientesState {
  final List<CobroPendiente> cobros;
  const CobrosPedientesBuilding(this.cobros);
}

class CobrosPendientesLoading extends CobrosPendientesState {}

class CobrosPendientesSuccess extends CobrosPendientesState {}

class CobrosPendientesInitial extends CobrosPendientesState {}
