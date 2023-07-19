part of 'cobros_bloc.dart';

abstract class CobrosState extends Equatable {
  const CobrosState();

  @override
  List<Object> get props => [];
}

class CobroLoading extends CobrosState {}

class CobrosPendientes extends CobrosState {
  final ClienteSaldoPendiente deuda;
  final bool showDialog;
  const CobrosPendientes(this.deuda, {required this.showDialog}) : super();
}

class CobrosSuccess extends CobrosState {}

class CobrosInitial extends CobrosState {}
