import 'dart:collection';

import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:expense_notes/src/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionModel extends Cubit<List<TransactionItem>> {
  final ApiService api = ApiService(DataProvider.http, "transactions");

  late List<TransactionItem> _transactions = [];

  TransactionModel() : super([]);

  UnmodifiableListView<TransactionItem> get transactions =>
      UnmodifiableListView(_transactions);

  Future<void> fetch() async {
    var result = await api.get();

    _transactions = result
        .map((doc) => TransactionItem.fromMap(doc.value as Map, doc.key))
        .toList();

    emit(transactions);
  }

  Future<void> add(TransactionItem item) async {
    var key = await api.add(item.toJson());
    var newTran = TransactionItem(
        id: key, cost: item.cost, name: item.name, date: item.date);

    _transactions.add(newTran);

    emit(transactions);
  }

  Future<void> edit(TransactionItem item) async {
    var transactionIdx = _transactions.indexWhere((tran) => tran.id == item.id);
    if (transactionIdx > -1) {
      await api.update(item.toJson(), item.id.toString());
      _transactions[transactionIdx] = item;

      emit(transactions);
    }
  }

  Future<void> remove(TransactionItem item) async {
    await api.remove(item.id.toString());
    _transactions.remove(item);

    emit(transactions);
  }
}
