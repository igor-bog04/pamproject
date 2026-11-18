import 'flashcard.dart';
import 'result.dart';

abstract class CardRepository {
  Future<Result<List<Flashcard>>> fetchByDeck(int deckId);
  Future<Result<Flashcard>> create(Flashcard card);
  Future<Result<List<Flashcard>>> createMany(List<Flashcard> cards); // импорт
  Future<Result<Flashcard>> update(Flashcard card);
  Future<Result<void>> delete(int id);
}