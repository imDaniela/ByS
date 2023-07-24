import 'dart:async';

import 'package:bys_app/cobros_unificados/cobros/bloc/cobros_bloc.dart';
import 'package:bys_app/cobros_unificados/cobros/cobros_screen.dart';
import 'package:bys_app/cobros_unificados/cobros_pendientes/bloc/cobros_pedientes_bloc.dart';
import 'package:bys_app/cobros_unificados/cobros_pendientes/bloc/cobros_pendientes_event.dart';
import 'package:bys_app/cobros_unificados/cobros_pendientes/bloc/cobros_pendientes_state.dart';
import 'package:bys_app/cobros_unificados/cobros_pendientes/cobros_pendientes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CobrosUnificados extends StatefulWidget {
  const CobrosUnificados({Key? key}) : super(key: key);

  @override
  State<CobrosUnificados> createState() => _CobrosUnificadosState();
}

class _CobrosUnificadosState extends State<CobrosUnificados> with TickerProviderStateMixin {

  late TabController tabController = TabController(length: 2, vsync: this, initialIndex: 0)..addListener(() {
    searchController.clear();
    setState(() {});
  });

  TextEditingController searchController = TextEditingController();
  Timer? _debounce;


  // Date Time para cobros pendientes
  DateTime fechaCobroPendienteInicial = DateTime.now();
  DateTime fechaCobroPendienteFinal = DateTime.now();

  // Abrir el DateTime picker para cobros
  void _seleccionarFechaCobro(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: fechaCobroPendienteInicial, end: fechaCobroPendienteFinal),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        fechaCobroPendienteInicial = picked.start;
        fechaCobroPendienteFinal = picked.end;
      });
      _loadCobros();
    }
  }

  void _loadCobros() {
    context.read<CobrosPendientesBloc>()
      .add(GetCobrosPendientes(init: fechaCobroPendienteInicial, end: fechaCobroPendienteFinal, search: searchController.text));
    context.read<CobrosBloc>()
      .add(GetCobros(init: fechaCobroPendienteInicial, end: fechaCobroPendienteFinal, search: searchController.text));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // TODO Cargar lista de cobros
      // 
      // Cargar lista de cobros pendientes
      _loadCobros();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _blocs(
      builder: (context, cobros, cobrosPedientes) {
        return Column(
          children: [
            Container(
              color: const Color.fromRGBO(142, 11, 44, 1),
              height: MediaQuery.of(context).padding.top),
            Expanded(
              child: Stack(
                children: [
                  TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: [
                      CobrosScreen(state: cobros),
                      CobrosPendientesScreen(state: cobrosPedientes)
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FloatingActionButton(
                        backgroundColor: const Color.fromRGBO(142, 11, 44, 1),
                        onPressed: () {
                          _seleccionarFechaCobro(context);
                        },
                        child: const Icon(Icons.date_range, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1.5),
            SizedBox(
              height: kToolbarHeight,
              child: TabBar(
                indicatorColor: const Color.fromRGBO(142, 11, 44, 1),
                indicatorPadding: const EdgeInsets.only(bottom: 4),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 4,
                controller: tabController,
                tabs: const [
                  Tab(child: Text('Realizados', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))),
                  Tab(child: Text('Pendientes', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))),
                ]
              ),
            ),
            Container(
              width: 10000000,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 12, bottom: 12),
              child: TextField(
                  controller: searchController,
                  onChanged: (val) {
                    if (_debounce?.isActive ?? false)
                      _debounce!.cancel();
                    _debounce = Timer(
                        const Duration(milliseconds: 500), () {
                      // do something with query
                      _loadCobros();
                    });
                  },
                  cursorColor:
                      const Color.fromRGBO(142, 11, 44, 1),
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ), // Ícono antes del texto
                    filled:
                        true, // Enable filling the TextField background
                    fillColor: const Color.fromRGBO(212, 212,
                        212, 1), // Set the background color
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(142, 11, 44,
                              1)), // Set the border color when focused
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ))),
          ],
        );
      }
    );
  }

  // Blocs
  Widget _blocs({required Widget Function(BuildContext, CobrosState, CobrosPendientesState) builder}) {
    return BlocConsumer<CobrosBloc, CobrosState>(
      listener: (context, state) {
        if (state is CobrosSuccess) {
          Fluttertoast.showToast(
              msg: "Se ha rehow alizado el cobro con éxito",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Color.fromARGB(255, 0, 155, 0),
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, cobrosState) {
        return BlocConsumer<CobrosPendientesBloc, CobrosPendientesState>(
          listener: (_, __) {},
          builder: (context, cobrosPendientesState) {
            return builder(context, cobrosState, cobrosPendientesState);
          }
        );
      },
    );
  }

}