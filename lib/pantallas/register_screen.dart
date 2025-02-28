import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/user.dart';
import '../theme/colors.dart'; // Importa la paleta de colores

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate() && _passwordController.text == _confirmPasswordController.text) {
      final user = User(
        nombre: _nombreController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (await _dbHelper.getUserByEmail(user.email) == null) {
        await _dbHelper.insertUser(user);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('El correo ya está registrado')),
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor, // Usa el color primario
                    AppColors.secondaryColor, // Usa el color secundario
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
                child: Icon(
                  Icons.person_add,
                  color: AppColors.iconColor, // Usa el color de íconos
                  size: 100,
                ),
              ),
            ),

            // Contenido desplazable (formulario y botón "Registrarse")
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.25),
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: AppColors.cardColor, // Usa el color de las tarjetas
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
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            "Registro",
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: AppColors.textColor, // Usa el color de texto
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 30),
                          // Campo de nombre
                          TextFormField(
                            controller: _nombreController,
                            decoration: _inputDecoration('Nombre', Icons.person),
                            style: TextStyle(color: AppColors.textColor), // Usa el color de texto
                            validator: (value) => value!.isEmpty ? 'Ingrese su nombre' : null,
                          ),
                          const SizedBox(height: 20),
                          // Campo de correo
                          TextFormField(
                            controller: _emailController,
                            decoration: _inputDecoration('Correo', Icons.email),
                            style: TextStyle(color: AppColors.textColor), // Usa el color de texto
                            validator: _validateEmail,
                          ),
                          const SizedBox(height: 20),
                          // Campo de contraseña
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: _inputDecoration('Contraseña', Icons.lock),
                            style: TextStyle(color: AppColors.textColor), // Usa el color de texto
                            validator: (value) => value!.length < 6 ? 'Mínimo 6 caracteres' : null,
                          ),
                          const SizedBox(height: 20),
                          // Campo de confirmar contraseña
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: _inputDecoration('Confirmar Contraseña', Icons.lock),
                            style: TextStyle(color: AppColors.textColor), // Usa el color de texto
                            validator: (value) => value != _passwordController.text ? 'No coinciden' : null,
                          ),
                          const SizedBox(height: 30),
                          // Botón de registro
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondaryColor, // Usa el color secundario
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            onPressed: _registerUser,
                            child: Text(
                              'Registrarse',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.textColor, // Usa el color de texto
                                  ),
                            ),
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

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: AppColors.textColor.withOpacity(0.7)), // Texto claro
      prefixIcon: Icon(icon, color: AppColors.iconColor), // Ícono claro
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: AppColors.textColor.withOpacity(0.7)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: AppColors.textColor.withOpacity(0.7)),
      ),
      hintStyle: TextStyle(color: AppColors.textColor.withOpacity(0.5)), // Texto claro
    );
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) return 'Ingrese su correo';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Correo inválido';
    }
    return null;
  }
}