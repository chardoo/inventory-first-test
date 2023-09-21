import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Point {
  final double x, y;

  Point(this.x, this.y);
}

class CustomGraph extends StatefulWidget {
  const CustomGraph({super.key, required this.points});
  final List<Point> points;
  @override
  State<CustomGraph> createState() => _CustomGraphState();
}

class _CustomGraphState extends State<CustomGraph> {
  double findHighestNumber() {
    if (widget.points.isEmpty) {
      return 1;
    }

    double maxNumber =
        widget.points[0].y; // Initialize maxNumber with the first element
    final numbers = widget.points.map((e) => e.y).toList();
    for (double num in numbers) {
      if (num > maxNumber) {
        maxNumber = num;
      }
    }

    return maxNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: const FlGridData(
        show: false,
        drawVerticalLine: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (e, m) {
              return Text("$e");
            },
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: widget.points.length.toDouble(),
      minY: 0,
      maxY: findHighestNumber(),
      lineBarsData: [
        LineChartBarData(
          spots: widget.points.map((e) => FlSpot(e.x, e.y)).toList(),
          isCurved: true,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0,
                    0.2,
                    0.6
                  ],
                  colors: [
                    Colors.blueAccent,
                    Colors.blueAccent.shade100,
                    Colors.white
                  ])),
        ),
      ],
    );
  }
}
