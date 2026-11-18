import 'mock_store.dart';
import 'result.dart';
import 'session_repository.dart';
import 'study_session.dart';

class MockSessionRepository implements SessionRepository {
  MockSessionRepository(this._store);
  final MockStore _store;

  @override
  Future<Result<List<StudySession>>> fetchAll() async {
    final failure = await _store.networkGate();
    if (failure != null) return Err(failure);
    return Ok(List.of(_store.sessions));
  }
}