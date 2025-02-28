import 'package:flutter/material.dart';
import 'package:sismonet/pantallas/home_screen.dart';
import '../database/database_helper.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      // Obtener el usuario por su correo electrónico
      final user = await _dbHelper.getUserByEmail(email);

      if (user != null) {
        // Verificar la contraseña
        if (user.password == password) {
          // Login exitoso
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login exitoso')),
          );

          // Navegar a HomeScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          // Contraseña incorrecta
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contraseña incorrecta')),
          );
        }
      } else {
        // Usuario no encontrado
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario no registrado')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // Fondo con gradiente
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2D3250), // #2D3250
                    Color(0xFF424769), // #424769
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              width: double.infinity,
              height: size.height * 0.3,
            ),

            // Icono de usuario
            SafeArea(
              child: Container(
                margin: const EdgeInsets.only(top: 40),
                width: double.infinity,
                child: const Icon(
                  Icons.person_pin,
                  color: Colors.white,
                  size: 100,
                ),
              ),
            ),

            // Contenido desplazable (formulario y botón "Crear Nueva Cuenta")
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.25),
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D3250), // #2D3250
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white, // Texto blanco
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          // Campo de correo electrónico
                          TextFormField(
                            controller: _emailController,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: 'Correo electrónico',
                              labelStyle: TextStyle(color: Colors.white70), // Texto claro
                              prefixIcon: const Icon(Icons.email, color: Colors.white70),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: Colors.white70),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: Colors.white70),
                              ),
                              hintText: 'ejemplo@dominio.com',
                              hintStyle: TextStyle(color: Colors.white54),
                            ),
                            style: TextStyle(color: Colors.white), // Texto blanco
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese su correo electrónico';
                              }
                              final emailRegex = RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                caseSensitive: false,
                              );
                              if (!emailRegex.hasMatch(value)) {
                                return 'Correo electrónico inválido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          // Campo de contraseña
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              labelStyle: TextStyle(color: Colors.white70), // Texto claro
                              prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: Colors.white70),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: Colors.white70),
                              ),
                              suffixIcon: const Icon(Icons.visibility_off, color: Colors.white70),
                            ),
                            style: TextStyle(color: Colors.white), // Texto blanco
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese su contraseña';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          // Botón de ingresar
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF424769), // #424769
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            onPressed: _loginUser,
                            child: const Text(
                              'Ingresar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          // Enlace "Crear Nueva Cuenta"
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white70, // Texto claro
                              textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: const Text('Crear Nueva Cuenta'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}