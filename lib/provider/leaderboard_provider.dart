import 'package:flutter/material.dart';
import 'package:quiz/services/quizz_services.dart';

import '../app/finite_state.dart';
import '../app/result.dart';
import '../models/quiz_attempt.dart';

class LeaderboardProvider extends ChangeNotifier {
  final QuizService _service;

  LeaderboardProvider(this._service);

  MyState state = MyState.initial;
  String? error;
  List<QuizAttempt> entries = [];

  /// Ambil leaderboard per quizId (level)
  Future<void> fetchLeaderboard(String quizId, {int limit = 10}) async {
    state = MyState.loading;
    error = null;
    notifyListeners();

    final result = await _service.getLeaderboard(quizId, limit: limit);

    switch (result) {
      case Success(:final data):
        // konversi Map<String,dynamic> -> QuizAttempt
        entries = data;
        state = MyState.loaded;
        break;
      case Failure(:final message):
        error = message;
        entries = [];
        state = MyState.failed;
    }

    notifyListeners();
  }
}
