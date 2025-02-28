import 'package:flutter/material.dart';
import 'package:sismonet/pantallas/home_screen.dart';
import 'package:sismonet/pantallas/mostrar_data.dart';
import 'package:sismonet/pantallas/register_screen.dart';
import 'package:sismonet/pantallas/login_sreen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(),
      routes: {
        '/login': (context) => const MostrarData(),
        '/register': (context) => const RegisterScreen(),
        '/menuprincipal': (context) => const HomeScreen(),
        '/home': (context) => const HomeScreen(),
        '/historial': (context) => const HomeScreen(),
        '/configuracion': (context) => const HomeScreen(),
        '/Agregardispocitivos': (context) => const HomeScreen(),
        '/mostrar_datos': (context) => const MostrarData(),
      },
    );
  }
}