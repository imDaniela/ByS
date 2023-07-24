import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bys_app/cobros_unificados/cobros/api/cobros_api.dart';
import 'package:bys_app/cobros_unificados/cobros/models/cobro.dart';
import 'package:bys_app/pedidos/api/pedidos_api.dart';
import 'package:bys_app/pedidos/models/ClienteSaldoPendiente.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
part 'cobros_event.dart';
part 'cobros_state.dart';

class CobrosBloc extends Bloc<CobrosEvent, CobrosState> {
  CobrosBloc() : super(CobrosInitial()) {
    on<toggleDialogEvent>((event, emit) {
      if (state is CobrosPendientes) {
        CobrosPendientes estado = state as CobrosPendientes;
        emit(CobrosPendientes(estado.deuda, showDialog: false));
      }
    });

    on<CheckDeudaEvent>((event, emit) async {
      emit(CobroLoading());

      http.Response? resp = await PedidosApi.Saldo(event.codcli);
      if (resp != null) {
        if (resp.statusCode == 200) {
          ClienteSaldoPendiente saldo =
              ClienteSaldoPendiente.fromJson(resp.body);
          if (saldo.deuda > 0) {
            emit(CobrosPendientes(saldo, showDialog: event.showDialog));
          }
        }
      }
    });
    on<SaveCobroEvent>((event, emit) async {
      CobrosState estado = state;
      emit(CobroLoading());
      try {
        http.Response? resp = await CobrosApi.saveCobro(
            codcli: event.codcli,
            forma_pago: event.forma_pago,
            numfac: event.numfac,
            cobro: event.cobro,
            fecha: event.fecha);
        emit(CobrosSuccess());
        this.add(CheckDeudaEvent(event.codcli));
      } catch (ex) {
        emit(estado);
      }
    });
    on<DeleteCobroEvent>((event, emit) async {
      CobrosState estado = state;
      emit(CobroLoading());
      try {
        http.Response? resp = await CobrosApi.deleteCobro(
          codcli: event.codcli,
          numfac: event.numfac,
        );
        emit(CobrosSuccess());
        this.add(CheckDeudaEvent(event.codcli, showDialog: false));
      } catch (ex) {
        emit(estado);
      }
    });
    on<GetCobros>((event, emit) async {
      emit(CobroLoading());
      List<Cobro> cobros = [];
      try {
        final response = await CobrosApi.getCobros(
          inicio: event.init,
          fin: event.end,
          search: event.search,
        );
        if (response.statusCode == 200) {
          if (response.body != 'null') {
            List<dynamic> body = jsonDecode(response.body);
            for (final cobro in body) {
              cobros.add(Cobro.fromMap(cobro));
            }
            emit(CobrosBuilding(cobros));
          }
        }
      } catch (_) {}
    });
  }
}
