import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentAnswerProvider extends ChangeNotifier {
  Map<int, List<String?>> answersPerLevel = {}; // jawaban per level
  int currentQuestionIndex = 0;

  /// Tambah jawaban siswa
  void setAnswer({
    required int level,
    required int questionIndex,
    required String answer,
  }) {
    answersPerLevel[level] ??= [];
    if (questionIndex >= answersPerLevel[level]!.length) {
      answersPerLevel[level]!.length = questionIndex + 1;
    }
    answersPerLevel[level]![questionIndex] = answer;
    notifyListeners();
  }

  String? getAnswer({required int level, required int questionIndex}) {
    return answersPerLevel[level] != null &&
            questionIndex < answersPerLevel[level]!.length
        ? answersPerLevel[level]![questionIndex]
        : null;
  }

  int correctAnswersCount(int level, List<String> correctAnswers) {
    final userAnswers = answersPerLevel[level] ?? [];
    int correct = 0;
    for (int i = 0; i < userAnswers.length; i++) {
      if (i < correctAnswers.length && userAnswers[i] == correctAnswers[i]) {
        correct++;
      }
    }
    return correct;
  }

  /// Helper untuk leaderboard: hitung skor
  int calculateScore(int level, List<String> correctAnswers) {
    return correctAnswersCount(level, correctAnswers);
  }

  /// Simpan skor ke Firebase
  Future<void> saveScoreToFirebase({
    required String userId,
    required String userName,
    required int level,
    required List<String> correctAnswers,
  }) async {
    final score = calculateScore(level, correctAnswers);
    await FirebaseFirestore.instance
        .collection('leaderboard')
        .doc('${userId}_level_$level')
        .set({
          'uid': userId,
          'name': userName,
          'level': level,
          'score': score,
          'timestamp': FieldValue.serverTimestamp(),
        });
  }

  void resetLevel(int level) {
    answersPerLevel[level] = [];
    currentQuestionIndex = 0;
    notifyListeners();
  }

  void resetAll() {
    answersPerLevel.clear();
    currentQuestionIndex = 0;
    notifyListeners();
  }
}
