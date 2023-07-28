import 'package:bys_app/clientes_del_dia/client_screen.dart';
import 'package:bys_app/albaran_pendiente_por_facturar/albaran_screen.dart';
import 'package:bys_app/cobros/cobros_screen.dart';
import 'package:bys_app/cobros_unificados/cobros/cobros_screen.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:bys_app/pedidos/pedidos.dart';

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
