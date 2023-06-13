import 'package:bloc/bloc.dart';
import 'package:bys_app/clientes_del_dia/historial_cliente/api/history_api.dart';
import 'package:bys_app/clientes_del_dia/historial_cliente/model/history.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryStateInitial()) {
    on<LoadHistory>((event, emit) async {
      if (event.codcli != null) {
        emit(HistoryLoading());
        http.Response? resp = await HistoryApi.GetHistory(event.codcli!);
        if (resp != null) {
          if (resp.statusCode == 200) {
            List<Historial>? historial = Historial.fromJsonList(resp.body);
            if (historial != null) {
              emit(HistoryLoaded(historial: historial));
            }
          }
        }
      }
    });
  }
}
