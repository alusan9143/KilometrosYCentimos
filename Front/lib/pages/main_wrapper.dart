import 'package:flutter/material.dart';
import 'home_page.dart';
import 'kilometers_page.dart';
import 'fuel_page.dart';
import 'mechanic_page.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    KilometersPage(carId: '1'),
    FuelPage(carId: '1'),
    MechanicPage(carId: '1'),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white, // fondo blanco
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 4),
          ],
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: Colors.transparent,
            indicatorColor: Colors.blue.shade100, // 🔹 indicador del icono seleccionado
            iconTheme: MaterialStateProperty.all(
              const IconThemeData(color: Colors.blue, size: 28), // iconos siempre azules
            ),
          ),
          child: NavigationBar(
            height: 65,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
              NavigationDestination(icon: Icon(Icons.speed), label: 'Kms'),
              NavigationDestination(icon: Icon(Icons.local_gas_station), label: 'Combustible'),
              NavigationDestination(icon: Icon(Icons.build), label: 'Mecánico'),
            ],
          ),
        ),
      ),
    );
  }
}
