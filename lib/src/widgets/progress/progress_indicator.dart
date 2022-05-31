import 'package:expense_notes/src/models/app_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppLinearProgressIndicator extends StatefulWidget
    with PreferredSizeWidget {
  const AppLinearProgressIndicator({Key? key, required this.appBar})
      : super(key: key);

  final AppBar appBar;

  @override
  State<AppLinearProgressIndicator> createState() =>
      _AppLinearProgressIndicatorState();

  @override
  Size get preferredSize => Size.fromHeight((appBar.toolbarHeight ?? 0));
}

class _AppLinearProgressIndicatorState extends State<AppLinearProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });

    controller.repeat(reverse: false);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, model, child) => model.isLoading
          ? LinearProgressIndicator(
              backgroundColor: Colors.grey,
              value: controller.value,
              semanticsLabel: 'Is Loading',
            )
          : const Text(''),
    );
  }
}
