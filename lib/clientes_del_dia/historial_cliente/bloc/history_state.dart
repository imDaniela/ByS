part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryStateInitial extends HistoryState {
  List<Historial> historial;
  HistoryStateInitial({this.historial = const []}) : super();
}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  List<Historial>? historial;
  HistoryLoaded({this.historial}) : super();
}
