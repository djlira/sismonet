import 'package:flutter/material.dart';
import 'package:sismonet/theme/colors.dart'; // Importa los colores del tema

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryColor, // Fondo del Drawer
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.secondaryColor, // Fondo del encabezado
            ),
            child: const Text(
              'Menú',
              style: TextStyle(
                color: AppColors.textColor, // Letras con color del tema
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildListTile(
            title: 'Datos del MPU6050',
            icon: Icons.sensors,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/mostrar_datos');
            },
          ),
          _buildListTile(
            title: 'Historial',
            icon: Icons.history,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/historial');
            },
          ),
          _buildListTile(
            title: 'Configuración',
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Configuración no implementada',
                      style: TextStyle(color: AppColors.textColor)),
                  backgroundColor: AppColors.secondaryColor,
                ),
              );
            },
          ),
          _buildListTile(
            title: 'Acerca de',
            icon: Icons.info,
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Acerca de no implementado',
                      style: TextStyle(color: AppColors.textColor)),
                  backgroundColor: AppColors.secondaryColor,
                ),
              );
            },
          ),
          _buildListTile(
            title: 'Salir',
            icon: Icons.exit_to_app,
            iconColor: Colors.redAccent,
            onTap: () {
              Navigator.pop(context);
              _confirmarSalida(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required IconData icon,
    Color iconColor = Colors.white,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: AppColors.textColor),
      ),
      leading: Icon(icon, color: iconColor),
      onTap: onTap,
    );
  }

  void _confirmarSalida(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.secondaryColor, // Fondo del diálogo
        title: Text(
          '¿Estás seguro?',
          style: TextStyle(color: AppColors.textColor),
        ),
        content: Text(
          '¿Deseas salir de la aplicación?',
          style: TextStyle(color: AppColors.textColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar', style: TextStyle(color: AppColors.textColor)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
            child: const Text('Salir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
