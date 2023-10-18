import 'package:bys_app/inicio_sesion/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar(
      {required this.currentIndex, required this.onChange, Key? key})
      : super(key: key);
  final int currentIndex;
  final Function(int) onChange;
  @override
  State<AppNavigationBar> createState() => _AppNavigationBar();
}

class _AppNavigationBar extends State<AppNavigationBar> {
  void _onItemTapped(int index) {
    if (index < 5) {
      widget.onChange(index);
    } else {
      context.read<LoginBloc>().add(LogOut());

      Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(142, 11, 44, 1),
      currentIndex: widget.currentIndex,
      onTap: _onItemTapped,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      elevation: 1,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: Color.fromRGBO(142, 11, 44, 1),
          icon: Icon(
            Icons.person,
          ),
          label: 'Clientes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.rectangle_outlined),
          label: 'Pedidos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.euro),
          label: 'Cobros',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.file_open),
          label: 'Archivos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_2),
          label: 'Perfil',
        ),
      ],
    );
  }
}
