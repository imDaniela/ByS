import 'dart:convert';
import 'package:bys_app/cobros_unificados/cobros/api/cobros_realizados_api.dart';
import 'package:bys_app/cobros_unificados/cobros/bloc/cobros_realizados_event.dart';
import 'package:bys_app/cobros_unificados/cobros/bloc/cobros_realizados_state.dart';
import 'package:bys_app/cobros_unificados/cobros/models/cobro.dart';
import 'package:bys_app/pedidos/api/pedidos_api.dart';
import 'package:bys_app/pedidos/models/ClienteSaldoPendiente.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class CobrosRealizadosBloc
    extends Bloc<CobrosRealizadosEvent, CobrosRealizadosState> {
  CobrosRealizadosBloc() : super(CobrosRealizadosInitial()) {
    on<CheckDeudaEvent>((event, emit) async {
      emit(CobrosRealizadosLoading());

      http.Response? resp = await PedidosApi.Saldo(event.codcli);
      if (resp != null) {
        if (resp.statusCode == 200) {
          ClienteSaldoPendiente saldo =
              ClienteSaldoPendiente.fromJson(resp.body);
          if (saldo.deuda > 0) {
            emit(CobrosRealizadosPendientes(saldo,
                showDialog: event.showDialog));
          }
        }
      }
    });
    on<GetCobrosRealizados>((event, emit) async {
      emit(CobrosRealizadosLoading());
      List<Cobro> cobros = [];
      try {
        final response = await CobrosRealizadosApi.getCobros(
            inicio: event.init,
            fin: event.end,
            search: event.search,
            metodo: event.metodo);
        if (response.statusCode == 200) {
          if (response.body != 'null') {
            List<dynamic> body = jsonDecode(response.body);
            for (final cobro in body) {
              cobros.add(Cobro.fromMap(cobro));
            }
            emit(CobrosRealizadosBuilding(cobros,
                inicio: event.init, fin: event.end));
          }
        }
      } catch (_) {}
    });
  }
}
