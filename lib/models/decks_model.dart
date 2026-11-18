import 'package:flutter/foundation.dart';
import '../data/deck.dart';
import '../data/deck_repository.dart';
import '../data/result.dart';

class DecksModel extends ChangeNotifier {
  DecksModel(this._repository); // DI: хранилище приходит через конструктор

  final DeckRepository _repository; // тип — ИНТЕРФЕЙС, а не mock

  bool _loading = false;
  String? _error;
  List<Deck> _decks = const [];

  bool get isLoading => _loading;
  String? get error => _error;
  List<Deck> get decks => List.unmodifiable(_decks);
  int get totalDue => _decks.fold(0, (sum, d) => sum + d.dueToday);
  int get totalCards => _decks.fold(0, (sum, d) => sum + d.cardCount);

  Deck? byId(int id) {
    for (final d in _decks) {
      if (d.id == id) return d;
    }
    return null;
  }

  Future<void> load() async {
    _loading = true;
    _error = null;
    notifyListeners(); // экраны входят в состояние «грузится»

    switch (await _repository.fetchAll()) {
      case Ok(:final value):
        _decks = value;
      case Err(:final msg):
        _error = msg;
    }
    _loading = false;
    notifyListeners(); // …и выходят: с данными или с ошибкой
  }

  // тихое обновление (счётчики после изменения карточек), без спиннера
  Future<void> refresh() async {
    if (await _repository.fetchAll() case Ok(:final value)) {
      _decks = value;
      notifyListeners();
    }
  }

  // null при успехе, текст ошибки при провале (как validator)
  Future<String?> add(Deck draft) async {
    switch (await _repository.create(draft)) {
      case Ok(:final value):
        _decks = [..._decks, value];
        notifyListeners();
        return null;
      case Err(:final msg):
        return msg;
    }
  }

  Future<String?> update(Deck deck) async {
    switch (await _repository.update(deck)) {
      case Ok(:final value):
        _decks = [for (final d in _decks) d.id == value.id ? value : d];
        notifyListeners();
        return null;
      case Err(:final msg):
        return msg;
    }
  }

  Future<String?> remove(int id) async {
    switch (await _repository.delete(id)) {
      case Ok():
        _decks = _decks.where((d) => d.id != id).toList();
        notifyListeners();
        return null;
      case Err(:final msg):
        return msg;
    }
  }
}