import 'package:flutter/material.dart';
import 'package:sismonet/pantallas/home_screen.dart';
import 'package:sismonet/theme/colors.dart'; // Importa la paleta de colores
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
      final user = await _dbHelper.getUserByEmail(email);

      if (user != null) {
        if (user.password == password) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login exitoso')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contraseña incorrecta')),
          );
        }
      } else {
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
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.secondaryColor, AppColors.primaryColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              width: double.infinity,
              height: double.infinity,
            ),
            SafeArea(
              child: Container(
                margin: const EdgeInsets.only(top: 40),
                width: double.infinity,
                child: const Icon(
                  Icons.person_pin,
                  color: AppColors.iconColor,
                  size: 100,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.25),
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
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
                          const Text(
                            "Login",
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: _emailController,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: 'Correo electrónico',
                              labelStyle: const TextStyle(color: AppColors.textColor),
                              prefixIcon: const Icon(Icons.email, color: AppColors.iconColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: AppColors.textColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: AppColors.textColor),
                              ),
                              hintText: 'ejemplo@dominio.com',
                              hintStyle: const TextStyle(color: AppColors.textColor),
                            ),
                            style: const TextStyle(color: AppColors.textColor),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              labelStyle: const TextStyle(color: AppColors.textColor),
                              prefixIcon: const Icon(Icons.lock, color: AppColors.iconColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: AppColors.textColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: AppColors.textColor),
                              ),
                              suffixIcon: const Icon(Icons.visibility_off, color: AppColors.iconColor),
                            ),
                            style: const TextStyle(color: AppColors.textColor),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            onPressed: _loginUser,
                            child: const Text(
                              'Ingresar',
                              style: TextStyle(color: AppColors.textColor, fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(context, '/register'),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.textColor,
                              textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
