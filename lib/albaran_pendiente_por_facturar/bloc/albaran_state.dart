part of 'albaran_bloc.dart';

abstract class AlbaranState extends Equatable {
  const AlbaranState();

  @override
  List<Object> get props => [];
}

class AlbaranInitial extends AlbaranState {
  List<Albaran>? albaranes;
  AlbaranInitial({this.albaranes}) : super();
}

class AlbaranLoading extends AlbaranState {}

class AlbaranLoaded extends AlbaranState {
  List<Albaran>? albaranes;
  AlbaranLoaded({this.albaranes}) : super();
}
