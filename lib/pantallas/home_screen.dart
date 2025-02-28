import 'package:flutter/material.dart';
import 'package:sismonet/menus/menu_drawer.dart'; // Importa el widget personalizado

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E3250), // Fondo oscuro para la pantalla
      appBar: AppBar(
        backgroundColor: const Color(0xFF424669), // Fondo oscuro para la AppBar
        title: const Text(
          'Bienvenido',
          style: TextStyle(color: Colors.white), // Letras blancas
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white), // Ícono blanco
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: const MenuDrawer(), // Aquí llamas al MenuDrawer
      body: const Center(
        child: Text(
          'Contenido de la pantalla',
          style: TextStyle(color: Colors.white, fontSize: 18), // Letras blancas
        ),
      ),
    );
  }
}