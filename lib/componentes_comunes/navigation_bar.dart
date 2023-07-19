import 'package:flutter/material.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({
    required this.currentIndex,
    required this.onChange,
    Key? key}) : super(key: key);
  final int currentIndex;
  final Function(int) onChange;
  @override
  State<AppNavigationBar> createState() => _AppNavigationBar();
}

class _AppNavigationBar extends State<AppNavigationBar> {
  int _selectedIndex = 0;
  int currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Color.fromRGBO(142, 11, 44, 1),
      unselectedItemColor: Colors.grey,
      elevation: 1,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
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
      ],
    );
  }
}
