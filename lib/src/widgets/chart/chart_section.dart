import 'package:expense_notes/src/widgets/chart/chart.dart';
import 'package:flutter/material.dart';

class ChartSection extends StatelessWidget {
  const ChartSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 200, color: Colors.green, child: const Chart());
  }
}
