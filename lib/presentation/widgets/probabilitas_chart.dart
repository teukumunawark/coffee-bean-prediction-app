import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';

Widget probabilitasChart(
  List<String> xUserLabels,
  List<List<double>> dataRows,
) {
  LabelLayoutStrategy? xContainerLabelLayoutStrategy;
  ChartData chartData;
  ChartOptions chartOptions = const ChartOptions();
  chartData = ChartData(
    dataRows: dataRows,
    xUserLabels: xUserLabels,
    dataRowsLegends: const [
      '  Probabilitas',
    ],
    chartOptions: chartOptions,
  );
  var lineChartContainer = LineChartTopContainer(
    chartData: chartData,
    xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
  );

  var lineChart = LineChart(
    painter: LineChartPainter(
      lineChartContainer: lineChartContainer,
    ),
  );
  return lineChart;
}
