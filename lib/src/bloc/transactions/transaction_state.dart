import 'package:expense_notes/src/models/transaction_item.dart';

enum TransactionStatus { initial, loading, success, failure }

class TransactionState {
  const TransactionState({
    this.status = TransactionStatus.initial,
    this.transactions = const [],
  });
  final TransactionStatus status;
  final List<TransactionItem> transactions;

  TransactionState copyWith({
    TransactionStatus Function()? status,
    List<TransactionItem> Function()? transactions,
  }) {
    return TransactionState(
      status: status != null ? status() : this.status,
      transactions: transactions != null ? transactions() : this.transactions,
    );
  }
}
