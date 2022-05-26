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

  void edit(TransactionItem item) {
    var transactionIdx = _transactions.indexWhere((tran) => tran.id == item.id);
    if (transactionIdx > -1) {
      _transactions[transactionIdx] = item;

      notifyListeners();
    }
  }

  void remove(TransactionItem item) {
    _transactions.remove(item);

    notifyListeners();
  }
}
