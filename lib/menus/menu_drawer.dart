import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF424669), // Fondo oscuro para el Drawer
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF2E3250), // Fondo oscuro para el encabezado
            ),
            child: Text(
              'Menú',
              style: TextStyle(
                color: Colors.white, // Letras blancas
                fontSize: 30,
                fontWeight: FontWeight.bold, // Texto en negrita
              ),
            ),
          ),
          _buildListTile(
            title: 'Datos del MPU6050',
            icon: Icons.sensors,
            onTap: () {
              Navigator.pop(context); // Cierra el Drawer
              Navigator.pushNamed(context, '/login');
            },
          ),
          _buildListTile(
            title: 'Configuración',
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Configuración no implementada')),
              );
            },
          ),
          _buildListTile(
            title: 'Acerca de',
            icon: Icons.info,
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Acerca de no implementado')),
              );
            },
          ),
          _buildListTile(
            title: 'Salir',
            icon: Icons.exit_to_app,
            iconColor: const Color.fromARGB(255, 255, 17, 0),
            onTap: () {
              Navigator.pop(context);
              _confirmarSalida(context);
            },
          ),
        ],
      ),
    );
  }

  // Método para construir ListTiles con menos repetición de código
  Widget _buildListTile({
    required String title,
    required IconData icon,
    Color iconColor = Colors.white,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      leading: Icon(icon, color: iconColor),
      onTap: onTap,
    );
  }

  // Método para confirmar la salida
  void _confirmarSalida(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2E3250), // Fondo oscuro del diálogo
        title: const Text(
          '¿Estás seguro?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          '¿Deseas salir de la aplicación?',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
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
