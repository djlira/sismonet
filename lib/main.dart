import 'package:flutter/material.dart';
import 'package:sismonet/pantallas/Historial_screen.dart';
import 'package:sismonet/pantallas/home_screen.dart';
import 'package:sismonet/pantallas/mostrar_data.dart';
import 'package:sismonet/pantallas/register_screen.dart';
import 'package:sismonet/pantallas/login_sreen.dart';
import 'package:sismonet/theme/colors.dart'; // Importa la paleta de colores

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta el banner de depuración
      title: 'Sismonet', // Nombre de la aplicación
      theme: ThemeData(
        primaryColor: AppColors.primaryColor, // Color primario
        scaffoldBackgroundColor: AppColors.primaryColor, // Fondo de las pantallas
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.secondaryColor, // Color de la AppBar
          titleTextStyle: TextStyle(
            color: AppColors.textColor, // Color del texto en la AppBar
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: AppColors.iconColor), // Color de los íconos
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.textColor, fontSize: 18), // Estilo de texto
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(), // Pantalla inicial
      routes: {
        // Definición de rutas
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/menuprincipal': (context) => const HomeScreen(),
        '/home': (context) => const HomeScreen(),
        '/historial': (context) => const HistorialScreen(),
        '/configuracion': (context) => const HomeScreen(),
        '/Agregardispocitivos': (context) => const HomeScreen(),
        '/mostrar_datos': (context) => const MostrarData(),
      },
    );
  }
}