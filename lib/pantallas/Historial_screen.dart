import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';

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
      appBar: AppBar(
        title: const Text('Historial Sísmico'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              focusedDay: _selectedDay,
              firstDay: DateTime(2024, 1, 1),
              lastDay: DateTime(2026, 12, 31),
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
              },
            ),
            const SizedBox(height: 20),
            _buildChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    List<double> data = _sismicData[_selectedDay] ?? [];
    return data.isEmpty
        ? const Center(child: Text('No hay datos para este día'))
        : SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(
                      data.length,
                      (index) => FlSpot(index.toDouble(), data[index]),
                    ),
                    isCurved: true,
                    color: Colors.deepPurple,
                    dotData: FlDotData(show: false),
                  ),
                ],
              ),
            ),
          );
  }
}
