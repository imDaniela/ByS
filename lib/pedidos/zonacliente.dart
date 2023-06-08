import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:bys_app/pedidos/pedidos.dart';
import 'package:bys_app/productos/bloc/productos_bloc.dart';
import 'package:bys_app/productos/models/producto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ZonaCliente extends StatefulWidget {
  const ZonaCliente({Key? key}) : super(key: key);

  @override
  State<ZonaCliente> createState() => _ZonaClienteState();
}

class _ZonaClienteState extends State<ZonaCliente> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductosBloc>().add(LoadProductos());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(142, 11, 44, 1),
            title: BlocBuilder<ClientesdiaBloc, ClientesdiaState>(
              builder: (context, state) => Text(state is ClientesdiaLoaded
                  ? state.cliente?.cal2 ?? ''
                  : 'TabBar Sample'),
            ),
            bottom: const TabBar(
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
          body: const TabBarView(
            children: <Widget>[
              PedidosScreen(),
              Center(
                child: Text("WIP"),
              ),
              Center(
                child: Text("WIP"),
              ),
              Center(
                child: Text("WIP"),
              ),
            ],
          ),
        ));
  }
}
