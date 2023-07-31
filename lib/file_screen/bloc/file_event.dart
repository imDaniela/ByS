part of 'file_bloc.dart';

abstract class FileEvent extends Equatable {
  const FileEvent();

  @override
  List<Object> get props => [];
}

class Loadfiles extends FileEvent {}
