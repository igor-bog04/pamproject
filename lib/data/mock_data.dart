class Flashcard {
  final int id;
  final String front;
  final String back;

  const Flashcard(this.id, this.front, this.back);
}

const mockCards = [
  Flashcard(1, 'to arrive', 'прибывать'),
  Flashcard(2, 'to borrow', 'брать взаймы'),
  Flashcard(3, 'to forget', 'забывать'),
  Flashcard(4, 'to improve', 'улучшать'),
  Flashcard(5, 'to suggest', 'предлагать'),
  Flashcard(6, 'to refuse', 'отказываться'),
  Flashcard(7, 'to provide', 'обеспечивать, предоставлять'),
  Flashcard(8, 'to achieve', 'достигать'),
];

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
class StudySession {
  final int id;
  final String deckName;
  final String date;
  final int reviewed;
  final int correct;

  const StudySession(
      this.id, this.deckName, this.date, this.reviewed, this.correct);
}

const mockSessions = [
  StudySession(1, 'Английский A2: глаголы', '06.10', 20, 17),
  StudySession(2, 'SQL: основные команды', '06.10', 14, 10),
  StudySession(3, 'Японский N5: хирагана', '05.10', 15, 12),
  StudySession(4, 'Алгоритмы: сложность O(n)', '04.10', 12, 9),
  StudySession(5, 'Формулы по физике', '03.10', 10, 9),
  StudySession(6, 'Английский A2: глаголы', '02.10', 18, 15),
  StudySession(7, 'Сети: модель OSI', '01.10', 8, 5),
  StudySession(8, 'История Молдовы', '30.09', 16, 14),
];