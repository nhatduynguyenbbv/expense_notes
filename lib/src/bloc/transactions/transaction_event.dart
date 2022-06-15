import '../../models/transaction_item.dart';

abstract class TransactionEvent {
  const TransactionEvent();
}

class TransactionFetch extends TransactionEvent {
  const TransactionFetch();
}

class TransactionAdd extends TransactionEvent {
  const TransactionAdd({required this.item});

  final TransactionItem item;
}

class TransactionEdit extends TransactionEvent {
  const TransactionEdit({required this.item});

  final TransactionItem item;
}

class TransactionRemove extends TransactionEvent {
  const TransactionRemove({required this.item});

  final TransactionItem item;
}
