import 'package:flutter/material.dart';
import 'package:quiz/models/app_user.dart';

import '../app/finite_state.dart';
import '../app/result.dart';
import '../models/question.dart';
import '../models/quiz.dart';
import '../models/quiz_attempt.dart';
import '../services/quizz_services.dart';

class QuizProvider extends ChangeNotifier {
  final QuizService _service;

  QuizProvider(this._service);

  MyState state = MyState.initial;
  String? error;

  List<Quiz> quizzes = [];
  List<Question> questions = [];

  // ==============================
  // Per-soal state
  // ==============================
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  bool showCorrectAnswer = false;
  List<int> selectedAnswers = [];

  // ==============================
  // Fetch data
  // ==============================
  Future<void> fetchQuizzes() async {
    state = MyState.loading;
    error = null;
    notifyListeners();

    final result = await _service.fetchQuizzes();

    switch (result) {
      case Success(:final data):
        quizzes = data;
        state = MyState.loaded;
        break;
      case Failure(:final message):
        state = MyState.failed;
        error = message;
    }

    notifyListeners();
  }

  Future<void> fetchQuestions(String quizId) async {
    state = MyState.loading;
    error = null;
    notifyListeners();

    final result = await _service.fetchQuestions(quizId);

    switch (result) {
      case Success(:final data):
        questions = data;
        // reset per-soal state
        currentQuestionIndex = 0;
        selectedAnswerIndex = null;
        showCorrectAnswer = false;
        selectedAnswers = [];
        state = MyState.loaded;
        break;
      case Failure(:final message):
        state = MyState.failed;
        error = message;
    }

    notifyListeners();
  }

  // ==============================
  // Pilih jawaban
  // ==============================
  void selectAnswer(int index) {
    if (!showCorrectAnswer) {
      selectedAnswerIndex = index;
      notifyListeners();
    }
  }

  // ==============================
  // Next question
  // ==============================
  void nextQuestion(AppUser user, int quizLevel) {
    if (selectedAnswerIndex == null) return;

    showCorrectAnswer = true;
    notifyListeners();

    // delay biar user bisa lihat jawaban benar
    Future.delayed(const Duration(seconds: 1), () async {
      selectedAnswers.add(selectedAnswerIndex!);

      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        showCorrectAnswer = false;
      } else {
        // semua selesai → submit attempt
        await submitQuizAttempt(user, quizLevel);
      }

      notifyListeners();
    });
  }

  // ==============================
  // Submit ke Firestore
  // ==============================
  Future<void> submitQuizAttempt(AppUser user, int levelQuiz) async {
    final attempt = QuizAttempt(
      quizId:
          levelQuiz == 1
              ? "quiz_1"
              : levelQuiz == 2
              ? "quiz_2"
              : "quiz_3",
      level: levelQuiz,
      userId: user.id,
      score: calculateScore(),
      time: 0, // kalau pakai timer
      completedAt: DateTime.now(),
    );

    final userName = user.name;
    await submitAttempt(attempt: attempt, userName: userName);
  }

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i].correctAnswer) {
        score += questions[i].score;
      }
    }
    return score;
  }

  // ==============================
  // Submit method (existing)
  // ==============================
  Future<void> submitAttempt({
    required QuizAttempt attempt,
    required String userName,
  }) async {
    state = MyState.loading;
    error = null;
    notifyListeners();

    final result = await _service.submitAttempt(
      attempt: attempt,
      userName: userName,
    );

    switch (result) {
      case Success():
        state = MyState.loaded;
        break;
      case Failure(:final message):
        state = MyState.failed;
        error = message;
    }

    notifyListeners();
  }
}
