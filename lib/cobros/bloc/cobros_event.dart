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
