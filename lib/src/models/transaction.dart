import 'dart:collection';

import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:flutter/foundation.dart';

class TransactionModel extends ChangeNotifier {
  final List<TransactionItem> _transactions = [];

  UnmodifiableListView<TransactionItem> get transactions =>
      UnmodifiableListView(_transactions);

  void add(TransactionItem item) {
    _transactions.add(item);

    notifyListeners();
  }

  void remove(TransactionItem item) {
    _transactions.remove(item);

    notifyListeners();
  }
}
