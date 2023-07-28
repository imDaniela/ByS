part of 'cobros_bloc.dart';

abstract class CobrosEvent extends Equatable {
  const CobrosEvent();

  @override
  List<Object> get props => [];
}

class CheckDeudaEvent extends CobrosEvent {
  final int codcli;
  final bool showDialog;
  const CheckDeudaEvent(this.codcli, {this.showDialog = true});
}

class toggleDialogEvent extends CobrosEvent {
  final bool toggle;
  const toggleDialogEvent(this.toggle);
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
