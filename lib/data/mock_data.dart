import 'deck.dart';
import 'flashcard.dart';
import 'study_session.dart';

const mockDecks = [
  Deck(1, 'Английский A2: глаголы', 'Языки'),
  Deck(2, 'Японский N5: хирагана', 'Языки'),
  Deck(3, 'Формулы по физике', 'Физика'),
  Deck(4, 'История Молдовы', 'История'),
  Deck(5, 'SQL: основные команды', 'Базы данных'),
  Deck(6, 'Сети: модель OSI', 'Сети'),
  Deck(7, 'Анатомия: кости черепа', 'Биология'),
  Deck(8, 'Алгоритмы: сложность O(n)', 'Программирование'),
];

const mockCards = [
  Flashcard(1, 1, 'to arrive', 'прибывать', due: true),
  Flashcard(2, 1, 'to borrow', 'брать взаймы', due: true),
  Flashcard(3, 1, 'to forget', 'забывать', due: true),
  Flashcard(4, 1, 'to improve', 'улучшать', due: true),
  Flashcard(5, 1, 'to suggest', 'предлагать', due: true),
  Flashcard(6, 1, 'to refuse', 'отказываться'),
  Flashcard(7, 1, 'to provide', 'обеспечивать, предоставлять'),
  Flashcard(8, 1, 'to achieve', 'достигать'),
  Flashcard(9, 2, 'あ', 'a', due: true),
  Flashcard(10, 2, 'い', 'i', due: true),
  Flashcard(11, 2, 'う', 'u'),
  Flashcard(12, 2, 'え', 'e'),
  Flashcard(13, 3, 'Второй закон Ньютона', 'F = ma', due: true),
  Flashcard(14, 3, 'Кинетическая энергия', 'E = mv²/2', due: true),
  Flashcard(15, 3, 'Закон Ома', 'I = U / R'),
  Flashcard(16, 4, 'Столица Молдовы', 'Кишинёв'),
  Flashcard(17, 4, 'Штефан чел Маре правил', '1457–1504'),
  Flashcard(18, 5, 'SELECT', 'выбрать столбцы', due: true),
  Flashcard(19, 5, 'JOIN', 'соединить таблицы', due: true),
  Flashcard(20, 5, 'GROUP BY', 'группировка строк', due: true),
  Flashcard(21, 5, 'HAVING', 'фильтр групп'),
  Flashcard(22, 6, 'Уровень 3 модели OSI', 'Сетевой', due: true),
  Flashcard(23, 6, 'Уровень 4 модели OSI', 'Транспортный'),
  Flashcard(24, 7, 'Кость лба', 'os frontale'),
  Flashcard(25, 8, 'Бинарный поиск', 'O(log n)', due: true),
  Flashcard(26, 8, 'Пузырьковая сортировка', 'O(n²)', due: true),
];

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