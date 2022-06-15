import 'package:expense_notes/src/bloc/transactions/transaction_event.dart';
import 'package:expense_notes/src/bloc/transactions/transaction_state.dart';
import 'package:expense_notes/src/models/transaction_item.dart';
import 'package:expense_notes/src/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(const TransactionState()) {
    on<TransactionFetch>(_onFetch);
    on<TransactionAdd>(_onAdd);
    on<TransactionRemove>(_onRemove);
    on<TransactionEdit>(_onEdit);
  }

  final ApiService api = ApiService(DataProvider.http, "transactions");

  Future<void> _onFetch(
    TransactionFetch event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: () => TransactionStatus.loading,
      ));

      final result = await api.get();
      final transactions = result
          .map((doc) => TransactionItem.fromMap(doc.value as Map, doc.key))
          .toList();

      emit(state.copyWith(
          status: () => TransactionStatus.success,
          transactions: () => transactions));
    } catch (e) {
      emit(state.copyWith(
        status: () => TransactionStatus.failure,
      ));
    }
  }

  Future<void> _onAdd(
    TransactionAdd event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: () => TransactionStatus.loading,
      ));
      final item = event.item;
      final key = await api.add(item.toJson());
      final newTran = TransactionItem(
          id: key, cost: item.cost, name: item.name, date: item.date);

      final transactions = state.transactions;
      transactions.add(newTran);

      emit(state.copyWith(
          status: () => TransactionStatus.success,
          transactions: () => transactions));
    } catch (e) {
      emit(state.copyWith(
        status: () => TransactionStatus.failure,
      ));
    }
  }

  Future<void> _onRemove(
    TransactionRemove event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: () => TransactionStatus.loading,
      ));

      final item = event.item;
      await api.remove(item.id.toString());

      final transactions = state.transactions;
      transactions.remove(item);

      emit(state.copyWith(
          status: () => TransactionStatus.success,
          transactions: () => transactions));
    } catch (e) {
      emit(state.copyWith(
        status: () => TransactionStatus.failure,
      ));
    }
  }

  Future<void> _onEdit(
      TransactionEdit event, Emitter<TransactionState> emit) async {
    try {
      emit(state.copyWith(
        status: () => TransactionStatus.loading,
      ));

      final item = event.item;
      final transactions = state.transactions;
      final transactionIdx =
          transactions.indexWhere((tran) => tran.id == item.id);

      if (transactionIdx > -1) {
        await api.update(item.toJson(), item.id.toString());
        transactions[transactionIdx] = item;

        emit(state.copyWith(
            status: () => TransactionStatus.success,
            transactions: () => transactions));
      } else {
        emit(state.copyWith(status: () => TransactionStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(
        status: () => TransactionStatus.failure,
      ));
    }
  }
}
