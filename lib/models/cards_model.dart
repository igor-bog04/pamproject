import 'package:flutter/foundation.dart';
import '../data/card_repository.dart';
import '../data/flashcard.dart';
import '../data/result.dart';

class CardsModel extends ChangeNotifier {
  CardsModel(this._repository, {this.onChanged});

  final CardRepository _repository;
  // вызывается после успешной мутации: корень связывает с обновлением колод
  final Future<void> Function()? onChanged;

  int? _deckId;
  bool _loading = false;
  String? _error;
  List<Flashcard> _cards = const [];

  int? get deckId => _deckId;
  bool get isLoading => _loading;
  String? get error => _error;
  List<Flashcard> get cards => List.unmodifiable(_cards);

  Flashcard? byId(int id) {
    for (final c in _cards) {
      if (c.id == id) return c;
    }
    return null;
  }

  Future<void> load(int deckId) async {
    _deckId = deckId;
    _cards = const [];
    _loading = true;
    _error = null;
    notifyListeners();

    final result = await _repository.fetchByDeck(deckId);
    if (_deckId != deckId) return; // успели открыть другую колоду

    switch (result) {
      case Ok(:final value):
        _cards = value;
      case Err(:final msg):
        _error = msg;
    }
    _loading = false;
    notifyListeners();
  }

  Future<String?> add(Flashcard draft) async {
    switch (await _repository.create(draft)) {
      case Ok(:final value):
        if (value.deckId == _deckId) _cards = [..._cards, value];
        notifyListeners();
        onChanged?.call();
        return null;
      case Err(:final msg):
        return msg;
    }
  }

  Future<String?> addAll(int deckId, List<(String, String)> pairs) async {
    final drafts = [for (final p in pairs) Flashcard(0, deckId, p.$1, p.$2)];
    switch (await _repository.createMany(drafts)) {
      case Ok(:final value):
        if (deckId == _deckId) _cards = [..._cards, ...value];
        notifyListeners();
        onChanged?.call();
        return null;
      case Err(:final msg):
        return msg;
    }
  }

  Future<String?> update(Flashcard card) async {
    switch (await _repository.update(card)) {
      case Ok(:final value):
        _cards = [for (final c in _cards) c.id == value.id ? value : c];
        notifyListeners();
        return null;
      case Err(:final msg):
        return msg;
    }
  }

  Future<String?> remove(int id) async {
    switch (await _repository.delete(id)) {
      case Ok():
        _cards = _cards.where((c) => c.id != id).toList();
        notifyListeners();
        onChanged?.call();
        return null;
      case Err(:final msg):
        return msg;
    }
  }
}