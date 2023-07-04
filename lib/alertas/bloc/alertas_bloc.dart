import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bys_app/alertas/api/alertas_api.dart';
import 'package:bys_app/alertas/model/Alerta.dart';
import 'package:bys_app/general/const.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'alertas_event.dart';
part 'alertas_state.dart';

class AlertasBloc extends Bloc<AlertasEvent, AlertasState> {
  AlertasBloc() : super(AlertasInitial()) {
    on<LoadAlertas>((event, emit) async {
      emit(AlertasLoading());
      http.Response resp = await AlertasApi.getAlertas();
      if (resp.statusCode == 200) {
        List<Alerta> alertas = Alerta.fromJsonList(resp.body) ?? [];
        emit(AlertasLoaded(alertas));
      }
    });
    on<SaveAlerta>((event, emit) async {
      emit(AlertasLoading());
      http.Response resp = await AlertasApi.saveAlerta(
          id: event.id,
          codcli: event.codcli,
          descripcion: event.descripcion,
          fecha: event.fecha);
      if (resp.statusCode == 200) {
        GlobalConstants.ScheduleNotification(event.descripcion, event.cliente,
            event.fecha, int.parse(resp.body));
        add(LoadAlertas());
      }
    });
    on<deleteAlertas>((event, emit) async {
      emit(AlertasLoading());
      http.Response resp = await AlertasApi.deleteAlerta(
        id: event.id,
      );
      if (resp.statusCode == 200) {
        GlobalConstants.deleteNotification(event.id);
        add(LoadAlertas());
      }
    });
  }
}
