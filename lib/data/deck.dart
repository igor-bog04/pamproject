class Deck {
  final int id;
  final String name;
  final String subject;
  final int cardCount;
  final int dueToday;

  const Deck(this.id, this.name, this.subject,
      {this.cardCount = 0, this.dueToday = 0});

  Deck copyWith({
    int? id,
    String? name,
    String? subject,
    int? cardCount,
    int? dueToday,
  }) =>
      Deck(id ?? this.id, name ?? this.name, subject ?? this.subject,
          cardCount: cardCount ?? this.cardCount,
          dueToday: dueToday ?? this.dueToday);
}