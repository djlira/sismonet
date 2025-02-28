import 'package:flutter/material.dart';
import 'package:sismonet/menus/menu_drawer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sismonet/theme/colors.dart'; // Importa la paleta de colores

class HistorialScreen extends StatefulWidget {
  const HistorialScreen({super.key});

  @override
  _HistorialScreenState createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  DateTime _selectedDay = DateTime.now();
  final Map<DateTime, List<double>> _sismicData = {
    DateTime(2025, 2, 26): [1.2, 2.3, 3.1, 2.8, 1.5],
    DateTime(2025, 2, 27): [0.5, 1.1, 2.6, 3.0, 1.8],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
       drawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCalendar(),
            const SizedBox(height: 20),
            _buildChart(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    
    return AppBar(
      title: const Text('Lectura'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      focusedDay: _selectedDay,
      firstDay: DateTime(2024, 1, 1),
      lastDay: DateTime(2026, 12, 31),
      calendarFormat: CalendarFormat.month,
      selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() => _selectedDay = selectedDay);
      },
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(color: AppColors.secondaryColor.withOpacity(0.5), shape: BoxShape.circle),
        selectedDecoration: BoxDecoration(color: AppColors.secondaryColor, shape: BoxShape.circle),
      ),
      headerStyle: HeaderStyle(
        titleTextStyle: const TextStyle(color: AppColors.textColor, fontSize: 18),
        formatButtonTextStyle: const TextStyle(color: AppColors.textColor),
        leftChevronIcon: const Icon(Icons.chevron_left, color: AppColors.iconColor),
        rightChevronIcon: const Icon(Icons.chevron_right, color: AppColors.iconColor),
      ),
    );
  }

  Widget _buildChart() {
    List<double> data = _sismicData[_selectedDay] ?? [];
    if (data.isEmpty) {
      return Center(
        child: Text(
          'No hay datos para este día',
          style: const TextStyle(color: AppColors.textColor, fontSize: 16),
        ),
      );
    }
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(data.length, (index) => FlSpot(index.toDouble(), data[index])),
              isCurved: true,
              color: AppColors.secondaryColor,
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
