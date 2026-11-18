import 'deck.dart';
import 'deck_repository.dart';
import 'mock_store.dart';
import 'result.dart';

class MockDeckRepository implements DeckRepository {
  MockDeckRepository(this._store);
  final MockStore _store;

  static const _notFound = 'Колода не существует';

  int _indexOf(int id) => _store.decks.indexWhere((d) => d.id == id);

  // счётчики считает «сервер» по карточкам
  Deck _withCounts(Deck d) {
    final mine = _store.cards.where((c) => c.deckId == d.id);
    return d.copyWith(
      cardCount: mine.length,
      dueToday: mine.where((c) => c.due).length,
    );
  }

  @override
  Future<Result<List<Deck>>> fetchAll() async {
    final failure = await _store.networkGate();
    if (failure != null) return Err(failure);
    return Ok([for (final d in _store.decks) _withCounts(d)]);
  }

  @override
  Future<Result<Deck>> fetchById(int id) async {
    final failure = await _store.networkGate();
    if (failure != null) return Err(failure);
    final i = _indexOf(id);
    if (i == -1) return const Err(_notFound); // «404»
    return Ok(_withCounts(_store.decks[i]));
  }

  @override
  Future<Result<Deck>> create(Deck deck) async {
    final failure = await _store.networkGate();
    if (failure != null) return Err(failure);
    final created = deck.copyWith(id: _store.nextId());
    _store.decks.add(created);
    return Ok(_withCounts(created));
  }

  @override
  Future<Result<Deck>> update(Deck deck) async {
    final failure = await _store.networkGate();
    if (failure != null) return Err(failure);
    final i = _indexOf(deck.id);
    if (i == -1) return const Err(_notFound);
    final saved =
        _store.decks[i].copyWith(name: deck.name, subject: deck.subject);
    _store.decks[i] = saved;
    return Ok(_withCounts(saved));
  }

  @override
  Future<Result<void>> delete(int id) async {
    final failure = await _store.networkGate();
    if (failure != null) return Err(failure);
    final i = _indexOf(id);
    if (i == -1) return const Err(_notFound);
    _store.decks.removeAt(i);
    _store.cards.removeWhere((c) => c.deckId == id);
    return const Ok(null); // «204: удалил, отдать нечего»
  }
}