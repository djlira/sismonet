import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sismonet/menus/menu_drawer.dart';
import 'package:sismonet/theme/colors.dart';

class MostrarData extends StatefulWidget {
  const MostrarData({super.key});

  @override
  State<MostrarData> createState() => _MostrarDataState();
}

class _MostrarDataState extends State<MostrarData> {
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
      drawer: const MenuDrawer(),
      appBar: AppBar(
        title: const Text('Lectura'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildSensorCard(
                title: 'Acelerómetro',
                chart: _buildLineChart(accelerometerX, accelerometerY, accelerometerZ),
              ),
              const SizedBox(height: 20),
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

  Widget _buildSensorCard({required String title, required Widget chart}) {
    return Card(
      color: AppColors.cardColor,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(height: 200, child: chart),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart(List<double> xData, List<double> yData, List<double> zData) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          _buildLineChartBar(xData, AppColors.red),
          _buildLineChartBar(yData, AppColors.green),
          _buildLineChartBar(zData, AppColors.blue),
        ],
      ),
    );
  }

  LineChartBarData _buildLineChartBar(List<double> data, Color color) {
    return LineChartBarData(
      spots: data.asMap().entries.map((entry) => FlSpot(entry.key.toDouble(), entry.value)).toList(),
      isCurved: true,
      color: color,
      dotData: FlDotData(show: false),
    );
  }
}
