part of 'alertas_bloc.dart';

abstract class AlertasState extends Equatable {
  const AlertasState();

  @override
  List<Object> get props => [];
}

class AlertasInitial extends AlertasState {}

class AlertasLoading extends AlertasState {}

class AlertasLoaded extends AlertasState {
  final List<Alerta> alertas;
  const AlertasLoaded(this.alertas);
}
