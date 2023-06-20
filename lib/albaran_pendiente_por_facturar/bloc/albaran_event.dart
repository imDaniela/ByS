part of 'albaran_bloc.dart';

abstract class AlbaranEvent extends Equatable {
  const AlbaranEvent();

  @override
  List<Object> get props => [];
}

class LoadAlbaran extends AlbaranEvent {
  int codcli;
  LoadAlbaran({required this.codcli});
}
