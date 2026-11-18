import 'card_repository.dart';
import 'flashcard.dart';
import 'mock_store.dart';
import 'result.dart';

class MockCardRepository implements CardRepository {
  MockCardRepository(this._store);
  final MockStore _store;

  static const _notFound = 'Карточка не существует';

  @override
  Future<Result<List<Flashcard>>> fetchByDeck(int deckId) async {
    final failure = await _store.networkGate();
    if (failure != null) return Err(failure);
    return Ok(_store.cards.where((c) => c.deckId == deckId).toList());
  }

  @override
  Future<Result<Flashcard>> create(Flashcard card) async {
    final failure = await _store.networkGate();
    if (failure != null) return Err(failure);
    final created = card.copyWith(id: _store.nextId(), due: true);
    _store.cards.add(created);
    return Ok(created);
  }

  @override
  Future<Result<List<Flashcard>>> createMany(List<Flashcard> cards) async {
    final failure = await _store.networkGate();
    if (failure != null) return Err(failure);
    final created = [
      for (final c in cards) c.copyWith(id: _store.nextId(), due: true),
    ];
    _store.cards.addAll(created);
    return Ok(created);
  }

  @override
  Future<Result<Flashcard>> update(Flashcard card) async {
    final failure = await _store.networkGate();
    if (failure != null) return Err(failure);
    final i = _store.cards.indexWhere((c) => c.id == card.id);
    if (i == -1) return const Err(_notFound);
    final saved = _store.cards[i].copyWith(front: card.front, back: card.back);
    _store.cards[i] = saved;
    return Ok(saved);
  }

  @override
  Future<Result<void>> delete(int id) async {
    final failure = await _store.networkGate();
    if (failure != null) return Err(failure);
    final i = _store.cards.indexWhere((c) => c.id == id);
    if (i == -1) return const Err(_notFound);
    _store.cards.removeAt(i);
    return const Ok(null);
  }
}