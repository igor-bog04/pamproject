class Flashcard {
  final int id;
  final int deckId;
  final String front;
  final String back;
  final bool due; // пора повторять сегодня

  const Flashcard(this.id, this.deckId, this.front, this.back,
      {this.due = false});

  Flashcard copyWith({int? id, String? front, String? back, bool? due}) =>
      Flashcard(id ?? this.id, deckId, front ?? this.front, back ?? this.back,
          due: due ?? this.due);
}