import 'package:expense_notes/src/widgets/chart/chart.dart';
import 'package:flutter/material.dart';

class ChartSection extends StatelessWidget {
  const ChartSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        child: const Card(color: Colors.white, child: Chart()));
  }
}
