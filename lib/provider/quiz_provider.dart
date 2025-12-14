import 'package:flutter/material.dart';
import 'package:quiz/app/custom_transition.dart';
import 'package:quiz/app/navigator_keys.dart';
import 'package:quiz/models/app_user.dart';
import 'package:quiz/pages/siswa/pages/siswa_level_complate_view.dart';

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

  bool get isLastIndexQuestion => currentQuestionIndex == questions.length - 1;

  // ==============================
  // Next question
  // ==============================
  void nextQuestion(AppUser user, int quizLevel) {
    if (selectedAnswerIndex == null) return;

    showCorrectAnswer = true;
    notifyListeners();

    // delay biar user bisa lihat jawaban benar
    Future.delayed(const Duration(milliseconds: 1500), () async {
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
      userName: user.name,
    );

    final userName = user.name;
    await submitAttempt(attempt: attempt, userName: userName);
    // harusnya masuk ke halaman leader board
    navigatorKey.currentContext!.fadeReplace(SiswaLevelComplateView(attempt));
  }

  int calculateScore() {
    if (questions.isEmpty) return 0;

    int correctCount = 0;

    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i].correctAnswer) {
        correctCount++;
      }
    }

    // Hitung persentase, bulatkan ke integer
    double ratio = (correctCount / questions.length) * 100;
    return ratio.round(); // .round() supaya hasilnya bulat, misal 87%
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
