import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bys_app/file_screen/api/file_api.dart';
import 'package:bys_app/file_screen/modelo/Archivo.dart';
import 'package:bys_app/general/const.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  FileBloc() : super(FileInitial()) {
    on<Loadfiles>((event, emit) async {
      emit(FileLoading());
      http.Response resp = await FilesApi.getArchivos(event.tipo);
      http.Response resp_todos = await FilesApi.getArchivosTodos(event.tipo);

      if (resp != null) {
        List<dynamic> result = jsonDecode((resp.body));
        List<dynamic> result_todos = jsonDecode((resp_todos.body));

        List<Archivo> res = [];

        result.forEach((element) {
          res.add(Archivo(
              nombre: element.toString(),
              url:
                  '${GlobalConstants.apiEndPoint}get-archivo/${event.tipo}/${element.toString()}'));
        });
        result_todos.forEach((element) {
          res.add(Archivo(
              nombre: element.toString(),
              url:
                  '${GlobalConstants.apiEndPoint}get-archivo/todos/${event.tipo}/${element.toString()}'));
        });
        emit(FileList(res));
      }
    });
  }
}
