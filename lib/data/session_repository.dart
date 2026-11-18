import 'result.dart';
import 'study_session.dart';

abstract class SessionRepository {
  Future<Result<List<StudySession>>> fetchAll();
}