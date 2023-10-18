import 'dart:convert';

import 'package:bys_app/cobros_unificados/cobros_pendientes/api/cobros_pendientes_api.dart';
import 'package:bys_app/cobros_unificados/cobros_pendientes/bloc/cobros_pendientes_event.dart';
import 'package:bys_app/cobros_unificados/cobros_pendientes/bloc/cobros_pendientes_state.dart';
import 'package:bys_app/cobros_unificados/cobros_pendientes/models/cobro_pendiente.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CobrosPendientesBloc
    extends Bloc<CobrosPendientesEvent, CobrosPendientesState> {
  CobrosPendientesBloc() : super(CobrosPendientesInitial()) {
    on<GetCobrosPendientes>((event, emit) async {
      emit(CobrosPendientesLoading());
      List<CobroPendiente> cobros = [];

      print('no entiendo');
      // try {
      final response = await CobrosPendientesApi.getCobros(
        inicio: event.init,
        fin: event.end,
        search: event.search,
      );
      if (response.statusCode == 200) {
        if (response.body != 'null') {
          List<dynamic> body = jsonDecode(response.body);
          for (final cobro in body) {
            cobros.add(CobroPendiente.fromMap(cobro));
          }
          emit(CobrosPedientesBuilding(cobros));
        }
      }
      //} catch (_) {}
    });
  }
}
