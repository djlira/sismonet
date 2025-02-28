import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sismonet/menus/menu_drawer.dart'; // Asegúrate de que esta ruta sea correcta

class MostrarData extends StatefulWidget {
  const MostrarData({super.key});

  @override
  State<MostrarData> createState() => _MPU6050ScreenState();
}

class _MPU6050ScreenState extends State<MostrarData> {
  // Datos iniciales para las gráficas
  List<double> accelerometerX = List.filled(50, 0.0);
  List<double> accelerometerY = List.filled(50, 0.0);
  List<double> accelerometerZ = List.filled(50, 0.0);
  List<double> gyroscopeX = List.filled(50, 0.0);
  List<double> gyroscopeY = List.filled(50, 0.0);
  List<double> gyroscopeZ = List.filled(50, 0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Integra el MenuDrawer aquí
      
      drawer: const MenuDrawer(), // Asegúrate de que MenuDrawer sea un Drawer válido
     appBar: AppBar(
        backgroundColor: const Color(0xFF424669), // Fondo oscuro para la AppBar
        title: const Text(
          'Lectura',
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
      backgroundColor: const Color(0xFF2D3250), // Color de fondo
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Gráfica del Acelerómetro
              _buildSensorCard(
                title: 'Acelerómetro',
                chart: _buildLineChart(accelerometerX, accelerometerY, accelerometerZ),
              ),
              const SizedBox(height: 20),
              // Gráfica del Giroscopio
              _buildSensorCard(
                title: 'Giroscopio',
                chart: _buildLineChart(gyroscopeX, gyroscopeY, gyroscopeZ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Tarjeta para mostrar la gráfica
  Widget _buildSensorCard({required String title, required Widget chart}) {
    return Card(
      color: const Color(0xFF424769), // Color de la tarjeta
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Gráfica
            SizedBox(
              height: 200,
              child: chart,
            ),
          ],
        ),
      ),
    );
  }

  // Gráfica de líneas para los datos del sensor
  Widget _buildLineChart(List<double> xData, List<double> yData, List<double> zData) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          // Datos del eje X
          LineChartBarData(
            spots: xData.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(), entry.value);
            }).toList(),
            isCurved: true,
            color: (Colors.red),
            dotData: FlDotData(show: false),
          ),
          // Datos del eje Y
          LineChartBarData(
            spots: yData.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(), entry.value);
            }).toList(),
            isCurved: true,
            color: (Colors.green),
            dotData: FlDotData(show: false),
          ),
          // Datos del eje Z
          LineChartBarData(
            spots: zData.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(), entry.value);
            }).toList(),
            isCurved: true,
            color: (Colors.blue),
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}