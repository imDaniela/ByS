import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bys_app/albaran_pendiente_por_facturar/model/albaran.dart';
import 'package:bys_app/albaran_pendiente_por_facturar/api/albaran_api.dart';
import 'package:http/http.dart' as http;

part 'albaran_event.dart';
part 'albaran_state.dart';

class AlbaranBloc extends Bloc<AlbaranEvent, AlbaranState> {
  AlbaranBloc() : super(AlbaranInitial()) {
    on<LoadAlbaran>((event, emit) async {
      if (event.codcli != null) {
        emit(AlbaranLoading());
        http.Response? resp = await AlbaranApi.GetAlbaranes(event.codcli!);
        if (resp != null) {
          if (resp.statusCode == 200) {
            List<Albaran>? albaranes = Albaran.fromJsonList(resp.body);
            if (albaranes != null) {
              emit(AlbaranLoaded(albaranes: albaranes));
            }
          }
        }
      }
    });
  }
}
