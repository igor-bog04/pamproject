import 'deck.dart';
import 'flashcard.dart';
import 'mock_data.dart';
import 'study_session.dart';

class MockStore {
  final List<Deck> decks = List.of(mockDecks);
  final List<Flashcard> cards = List.of(mockCards);
  final List<StudySession> sessions = List.of(mockSessions);

  int _nextId = 1000; // выше любого id из seed
  int nextId() => _nextId++; // id даёт ХРАНИЛИЩЕ

  bool simulateError = false; // авария: включена -> любой вызов падает

  static const latency = Duration(milliseconds: 800);
  static const errNetwork = 'Сервер не отвечает — повторите попытку';

  // сеть не отвечает мгновенно; null = можно продолжать, иначе текст ошибки
  Future<String?> networkGate() async {
    await Future.delayed(latency);
    return simulateError ? errNetwork : null;
  }
}