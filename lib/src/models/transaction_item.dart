class TransactionItem {
  const TransactionItem(
      {this.id, required this.cost, required this.name, required this.date});

  final String? id;
  final int cost;
  final String name;
  final DateTime date;

  factory TransactionItem.fromMap(Map snapshot, String key) {
    var dateString = (snapshot)["date"];
    return TransactionItem(
        id: key,
        cost: snapshot['cost'],
        name: snapshot["name"] ?? '',
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
