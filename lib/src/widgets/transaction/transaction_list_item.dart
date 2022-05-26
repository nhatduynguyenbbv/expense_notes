import 'dart:math';
import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:expense_notes/src/screens/transaction_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListItem extends StatefulWidget {
  const TransactionListItem(
      {Key? key, required this.item, required this.onDelete})
      : super(key: key);

  final TransactionItem item;

  final void Function(TransactionItem item) onDelete;

  @override
  State<TransactionListItem> createState() => _TransactionListItemState();
}

class _TransactionListItemState extends State<TransactionListItem> {
  late Color randomColor;
  @override
  void initState() {
    super.initState();
    randomColor = _randomColor() ?? Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.pushNamed(context, TransactionDetail.routeName,
            arguments: widget.item)
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: randomColor, width: 2)),
                      child: Text(
                        '\$${widget.item.cost.toDouble().toString()}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: randomColor),
                      ),
                    ),
                    Container(
                      height: 48,
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.item.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat('MMM d, yyyy').format(widget.item.date),
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () => widget.onDelete(widget.item),
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color? _randomColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)]
        [Random().nextInt(9) * 100];
  }
}
