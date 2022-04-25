import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('My Chart',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)));
  }
}
