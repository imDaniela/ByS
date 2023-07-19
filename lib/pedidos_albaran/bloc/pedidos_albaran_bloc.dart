import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bys_app/pedidos_albaran/api/pedidos_albaran_api.dart';
import 'package:bys_app/pedidos_albaran/bloc/pedidos_albara_state.dart';
import 'package:bys_app/pedidos_albaran/bloc/pedidos_albaran_event.dart';
import 'package:bys_app/pedidos_albaran/models/pedidoAlbaranDetalles.dart';
import 'package:bys_app/pedidos_albaran/models/pedidoAlbaranLinea.dart';
import 'package:flutter/foundation.dart';

class PedidosAlbaranBloc extends Bloc<PedidosAlbaranEvent, PedidosAlbaranState> {
  PedidosAlbaranBloc() : super(PedidosAlbaranInitial()) {
    on<InitPedidoAlbaranBuild>((event, emit) async {
      emit(const PedidoAlbaranBuilding());
    });

    on<SearchPedido>((event, emit) async {
      List<PedidoAlbaranLinea> lineas = [];
      emit(PedidoAlbaranLoading());
      try {
        final response = await PedidosAlbaranApi.searchPedido(event.query);
        if (response.statusCode == 200) {
          if (response.body != 'null') {
            List<dynamic> body = jsonDecode(response.body);
            for (final linea in body) {
              lineas.add(PedidoAlbaranLinea.fromMap(linea));
            }
            emit(PedidosAlbaranSuccess());
            emit(PedidoAlbaranBuilding(lineas: lineas));
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        emit(const PedidosAlbaranError('se murio'));
      }
    });

    on<GetPedidoAlbaran>((event, emit) async {
      List<PedidoAlbaranDetalles> lineas = [];
      emit(PedidoAlbaranLoading());
      try {
        final response = await PedidosAlbaranApi.getPedido(event.numeroAlbaran);
        if (response.statusCode == 200 && response.body != 'null') {
          List<dynamic> body = jsonDecode(response.body);
          for (final linea in body) {
            lineas.add(PedidoAlbaranDetalles.fromMap(linea));
          }
          emit(PedidosAlbaranSuccess());
          emit(PedidoAlbaranDetallesBuilding(lineas: lineas));
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        emit(const PedidosAlbaranError('se murio'));
      }
    });

  }
}
