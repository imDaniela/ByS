import 'package:equatable/equatable.dart';

abstract class CobrosPendientesEvent extends Equatable {
  const CobrosPendientesEvent();

  @override
  List<Object> get props => [];
}

class GetCobrosPendientes extends CobrosPendientesEvent {
  final DateTime init;
  final DateTime end;
  final String? search;
  const GetCobrosPendientes({required this.init, required this.end, this.search});
}

class GetDetallesCobroPendiente extends CobrosPendientesEvent {
  final int numeroFactura;
  const GetDetallesCobroPendiente({required this.numeroFactura});
}