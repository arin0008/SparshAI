import 'package:SparshAI/Data/chart_data/line_chart_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LineChartContent extends StatelessWidget {
  const LineChartContent({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
      minY: 75,
      maxY: 120,
      minX: 1,
      maxX: 30,
      gridData: FlGridData(show: false),
      lineBarsData: lineChartBarData,
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      extraLinesData: ExtraLinesData(extraLinesOnTop: false),
    ));
  }
}
