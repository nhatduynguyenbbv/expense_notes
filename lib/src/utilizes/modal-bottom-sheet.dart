import 'package:flutter/material.dart';

Future<T?> showCustomModalBottomSheet<T>(
    {required String title,
    required BuildContext context,
    required Widget content}) {
  return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      context: context,
      isScrollControlled: true,
      elevation: 5,
      builder: (context) => Padding(
          // padding: const EdgeInsets.symmetric(horizontal: 18),
          padding: EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                    title: Center(
                        child:
                            Text(title, style: const TextStyle(fontSize: 24)))),
                content,
              ])));
}
