class Counter {
  const Counter({required this.id, required this.value});
  final String id;
  final int value;

  factory Counter.fromMap(Map<String, dynamic> data, String documentID) {
    return Counter(
      id: documentID,
      value: data['value'],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'value': value,
      };

  Counter increment() => Counter(id: id, value: value + 1);
  Counter decrement() => Counter(id: id, value: value + 1);
}
