import 'dart:io';

import 'package:bys_app/clientes_del_dia/client_screen.dart';
import 'package:bys_app/albaran_pendiente_por_facturar/albaran_screen.dart';
import 'package:bys_app/cobros/cobros_screen.dart';
import 'package:bys_app/cobros_unificados/cobros/cobros_screen.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:bys_app/pedidos/NotasDialog.dart';
import 'package:bys_app/pedidos/api/pedidos_api.dart';
import 'package:bys_app/pedidos/bloc/pedidos_bloc.dart';
import 'package:bys_app/pedidos/pedidos.dart';
import 'package:whatsapp_share/whatsapp_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ZonaCliente extends StatefulWidget {
  const ZonaCliente({Key? key}) : super(key: key);

  @override
  State<ZonaCliente> createState() => _ZonaClienteState();
}

class _ZonaClienteState extends State<ZonaCliente>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(142, 11, 44, 1),
        title: BlocBuilder<ClientesdiaBloc, ClientesdiaState>(
          builder: (context, state) => Text(state is ClientesdiaLoaded
              ? state.cliente?.cal2 ?? ''
              : 'TabBar Sample'),
        ),
        actions: [
          BlocBuilder<ClientesdiaBloc, ClientesdiaState>(
              builder: (context, state_cliente) =>
                  BlocBuilder<PedidosBloc, PedidosState>(
                      builder: (context, state) => (state is PedidoBuilding)
                          ? (state_cliente is ClientesdiaLoaded)
                              ? (state.totales?.numped != null
                                  ? Container(
                                      margin: EdgeInsets.only(right: 40),
                                      child: InkWell(
                                        onTap: () async {
                                          File file =
                                              await PedidosApi.getPedidoPdf(
                                                  state.totales?.numped ?? 0);
                                          await WhatsappShare.shareFile(
                                              phone: '5',
                                              filePath: [file.path],
                                              package:
                                                  Package.businessWhatsapp);
                                        },
                                        child: Icon(Icons.message),
                                      ))
                                  : Container())
                              : Container()
                          : Container())),
          Container(
              margin: EdgeInsets.only(right: 40),
              child: BlocBuilder<PedidosBloc, PedidosState>(
                  builder: (context, state) =>
                      BlocBuilder<ClientesdiaBloc, ClientesdiaState>(
                          builder: (context, state_cliente) => InkWell(
                              onTap: () {
                                PedidoBuilding? estado;
                                if (state is PedidoBuilding) {
                                  estado = state as PedidoBuilding;
                                }
                                NotasDialog.openDialogWithData(
                                    context,
                                    (state_cliente as ClientesdiaLoaded)
                                        .cliente!
                                        .codcli,
                                    default_obs: estado?.totales?.observa,
                                    default_obs_int: estado?.totales?.obsint);
                              },
                              child: Icon(Icons.note_add)))))
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(
              icon: Text('Pedido'),
            ),
            Tab(
              icon: Text('Histórico Ventas'),
            ),
            Tab(
              icon: Text('Alb. Pdte. Facturar'),
            ),
            Tab(
              icon: Text('Fact. Últimos meses'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          PedidosScreen(),
          ClienteHistorial(
            tabcontroller: _tabController,
          ),
          AlbaranPendientePorFacturar(),
          CobrosScreen()
        ],
      ),
    );
  }
}
