import 'package:firebase_database/firebase_database.dart';

class TransactionItem {
  const TransactionItem(
      {this.id, required this.cost, required this.name, required this.date});

  final String? id;
  final int cost;
  final String name;
  final DateTime date;

  factory TransactionItem.fromSnapshot(DataSnapshot snapshot) {
    var dateString = (snapshot.value as Map)["date"];
    return TransactionItem(
        id: snapshot.key.toString(),
        cost: (snapshot.value as Map)['cost'] ?? 0,
        name: (snapshot.value as Map)["name"] ?? '',
        date: dateString != null ? DateTime.parse(dateString) : DateTime.now());
  }

  toJson() {
    return {
      "cost": cost,
      "name": name,
      "date": date.toString(),
    };
  }
}
