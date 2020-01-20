class Counter {
  Counter({this.id, this.value});
  int id;
  int value;

  factory Counter.fromMap(Map<String, dynamic> data, String documentID) {
    return Counter(
      id: int.tryParse(documentID),
      value: data['value'],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'value': value,
      };
}
