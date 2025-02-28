import 'package:flutter/material.dart';
import 'package:sismonet/menus/menu_drawer.dart';
import 'package:sismonet/theme/colors.dart'; // Importa la paleta de colores

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor, // Fondo de la pantalla
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor, // Fondo de la AppBar
        title: const Text(
          'Bienvenido',
          style: TextStyle(color: AppColors.textColor), // Letras del título
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: AppColors.iconColor), // Ícono
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const MenuDrawer(),
      body: const Center(
        child: Text(
          'Contenido de la pantalla',
          style: TextStyle(color: AppColors.textColor, fontSize: 18), // Texto principal
        ),
      ),
    );
  }
}
