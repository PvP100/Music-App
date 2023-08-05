class Tuple2<A, B> {
  A item1;
  B item2;

  Tuple2({required this.item1, required this.item2});

  Tuple2 copyWith({A? item1, B? item2}) {
    return Tuple2(
      item1: item1 ?? this.item1,
      item2: item2 ?? this.item2,
    );
  }
}

class Tuple3<A, B, C> {
  A item1;
  B item2;
  C item3;

  Tuple3({required this.item1, required this.item2, required this.item3});

  Tuple3 copyWith({A? item1, B? item2, C? item3}) {
    return Tuple3(
      item1: item1 ?? this.item1,
      item2: item2 ?? this.item2,
      item3: item3 ?? this.item3,
    );
  }
}
