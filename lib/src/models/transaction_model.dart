import 'dart:collection';

import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:expense_notes/src/services/api_service.dart';
import 'package:flutter/foundation.dart';

class TransactionModel extends ChangeNotifier {
  final ApiService api = ApiService(DataProvider.http, "transactions");

  late List<TransactionItem> _transactions = [];

  UnmodifiableListView<TransactionItem> get transactions =>
      UnmodifiableListView(_transactions);

  Future<void> fetch() async {
    var result = await api.get();

    _transactions = result
        .map((doc) => TransactionItem.fromMap(doc.value as Map, doc.key))
        .toList();

    notifyListeners();
  }

  Future<void> add(TransactionItem item) async {
    var key = await api.add(item.toJson());
    var newTran = TransactionItem(
        id: key, cost: item.cost, name: item.name, date: item.date);

    _transactions.add(newTran);

    notifyListeners();
  }

  Future<void> edit(TransactionItem item) async {
    var transactionIdx = _transactions.indexWhere((tran) => tran.id == item.id);
    if (transactionIdx > -1) {
      await api.update(item.toJson(), item.id.toString());
      _transactions[transactionIdx] = item;

      notifyListeners();
    }
  }

  Future<void> remove(TransactionItem item) async {
    await api.remove(item.id.toString());
    _transactions.remove(item);

    notifyListeners();
  }
}
