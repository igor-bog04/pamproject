import 'deck.dart';
import 'result.dart';

// Контракт: ЧТО можно просить, а не КАК
abstract class DeckRepository {
  Future<Result<List<Deck>>> fetchAll();
  Future<Result<Deck>> fetchById(int id);
  Future<Result<Deck>> create(Deck deck);
  Future<Result<Deck>> update(Deck deck);
  Future<Result<void>> delete(int id);
}