import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bys_app/file_screen/api/file_api.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  FileBloc() : super(FileInitial()) {
    on<Loadfiles>((event, emit) async {
      http.Response resp = await FilesApi.getArchivos();
      if (resp != null) {
        List<dynamic> result = jsonDecode((resp.body));
        List<String> res = [];
        result.forEach((element) {
          res.add(element.toString());
        });
        emit(FileList(res));
      }
    });
  }
}
