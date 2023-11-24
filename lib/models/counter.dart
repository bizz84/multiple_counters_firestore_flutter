class Counter {
  Counter({required this.id, required this.value});
  String id;
  int value;

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
}
