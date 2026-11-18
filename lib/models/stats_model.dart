import 'package:flutter/foundation.dart';
import '../data/result.dart';
import '../data/session_repository.dart';
import '../data/study_session.dart';

class StatsModel extends ChangeNotifier {
  StatsModel(this._repository);

  final SessionRepository _repository;

  bool _loading = false;
  String? _error;
  List<StudySession> _sessions = const [];

  bool get isLoading => _loading;
  String? get error => _error;
  List<StudySession> get sessions => List.unmodifiable(_sessions);
  int get reviewed => _sessions.fold(0, (sum, s) => sum + s.reviewed);
  int get correct => _sessions.fold(0, (sum, s) => sum + s.correct);
  int get accuracy => reviewed == 0 ? 0 : (correct * 100 / reviewed).round();

  Future<void> load() async {
    _loading = true;
    _error = null;
    notifyListeners();

    switch (await _repository.fetchAll()) {
      case Ok(:final value):
        _sessions = value;
      case Err(:final msg):
        _error = msg;
    }
    _loading = false;
    notifyListeners();
  }
}