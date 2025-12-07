import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:fastdx_app/widgets/widgets.dart';

class VendorChart extends StatelessWidget {
  const VendorChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      pt: 10,
      pl: 16,
      pr: 16,
      pb: 10,
      child: SizedBox(
        height: 250,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCardHeader.widget(
              label: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sales Overview",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Today's Performance",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                  ),
                ],
              ),
              actionLabel: "See Details",
            ),
            const SizedBox(height: 16),
            Expanded(child: LineChart(buildChartData(context))),
          ],
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(
    BuildContext context,
    double value,
    TitleMeta meta,
  ) {
    final style = Theme.of(context).textTheme.bodySmall!.copyWith();

    String text = switch (value.toInt()) {
      0 => '8AM',
      3 => '12PM',
      6 => '4PM',
      9 => '8PM',
      12 => '12AM',
      _ => '',
    };

    return SideTitleWidget(
      meta: meta,
      child: Text(text, style: style),
    );
  }

  LineChartData buildChartData(BuildContext context) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: false,
        drawVerticalLine: false,
        horizontalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.withValues(alpha: 0.15),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false), // Hide left axis
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            interval: 1,
            getTitlesWidget: (value, meat) =>
                bottomTitleWidgets(context, value, meat),
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 2.5), // 8AM
            FlSpot(1.5, 2), // 9:30AM
            FlSpot(3, 3.5), // 12PM
            FlSpot(4.5, 3), // 1:30PM
            FlSpot(6, 4.8), // 4PM
            FlSpot(7.5, 3.8), // 5:30PM
            FlSpot(9, 4.2), // 8PM
            FlSpot(10.5, 3.5), // 9:30PM
            FlSpot(12, 3), // 12AM
          ],
          isCurved: true,
          curveSmoothness: 0.35, // Smooth curve
          color: Theme.of(context).colorScheme.primary,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 2,
                color: Theme.of(context).colorScheme.primary,
                strokeWidth: 2,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
