class Deck {
  final int id;
  final String name;
  final String subject;
  final int cardCount;
  final int dueToday;

  const Deck(this.id, this.name, this.subject, this.cardCount, this.dueToday);
}

const mockDecks = [
  Deck(1, 'Английский A2: глаголы', 'Языки', 48, 12),
  Deck(2, 'Японский N5: хирагана', 'Языки', 46, 8),
  Deck(3, 'Формулы по физике', 'Физика', 25, 5),
  Deck(4, 'История Молдовы', 'История', 60, 0),
  Deck(5, 'SQL: основные команды', 'Базы данных', 32, 14),
  Deck(6, 'Сети: модель OSI', 'Сети', 21, 3),
  Deck(7, 'Анатомия: кости черепа', 'Биология', 28, 0),
  Deck(8, 'Алгоритмы: сложность O(n)', 'Программирование', 40, 9),
];