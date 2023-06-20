part of 'cobros_bloc.dart';

abstract class CobrosEvent extends Equatable {
  const CobrosEvent();

  @override
  List<Object> get props => [];
}

class CheckDeudaEvent extends CobrosEvent {
  final int codcli;
  const CheckDeudaEvent(this.codcli);
}

class DeleteCobroEvent extends CobrosEvent {
  final int codcli, numfac;
  const DeleteCobroEvent({required this.codcli, required this.numfac});
}

class SaveCobroEvent extends CobrosEvent {
  final int codcli, numfac;
  final String forma_pago;
  final double cobro;
  final DateTime fecha;
  const SaveCobroEvent(
      {required this.codcli,
      required this.numfac,
      required this.forma_pago,
      required this.cobro,
      required this.fecha});
}
