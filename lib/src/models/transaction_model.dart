import 'dart:collection';

import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:expense_notes/src/services/api_service.dart';
import 'package:flutter/foundation.dart';

class TransactionModel extends ChangeNotifier {
  final ApiService api = ApiService("transactions");

  late List<TransactionItem> _transactions = [];

  UnmodifiableListView<TransactionItem> get transactions =>
      UnmodifiableListView(_transactions);

  Future<void> fetch() async {
    var result = await api.get();

    _transactions = result.children
        .map((doc) => TransactionItem.fromSnapshot(doc))
        .toList();

    notifyListeners();
  }

  Future<void> add(TransactionItem item) async {
    var newItem = await api.add(item.toJson());

    _transactions.add(TransactionItem.fromSnapshot(newItem));

    notifyListeners();
  }

  Future<void> edit(TransactionItem item) async {
    var transactionIdx = _transactions.indexWhere((tran) => tran.id == item.id);
    if (transactionIdx > -1) {
      _transactions[transactionIdx] = item;

      await api.update(item.toJson(), item.id.toString());

      notifyListeners();
    }
  }

  Future<void> remove(TransactionItem item) async {
    _transactions.remove(item);
    await api.remove(item.id.toString());

    notifyListeners();
  }
}
