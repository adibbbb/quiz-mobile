import 'package:flutter/material.dart';

import '../app/finite_state.dart';
import '../app/result.dart';
import '../models/question.dart';
import '../models/quiz.dart';
import '../services/teacher_services.dart';

class TeacherProvider extends ChangeNotifier {
  final TeacherService _service;

  TeacherProvider(this._service);

  MyState state = MyState.initial;
  String? error;

  Future<void> saveQuiz(Quiz quiz) async {
    state = state.loading;
    error = null;
    notifyListeners();

    final result = await _service.saveQuiz(quiz);

    switch (result) {
      case Success():
        state = state.loaded;
        break;
      case Failure(:final message):
        state = state.failed;
        error = message;
    }

    notifyListeners();
  }

  Future<void> addQuestion({
    required String quizId,
    required Question question,
  }) async {
    state = state.loading;
    error = null;
    notifyListeners();

    final result = await _service.addQuestion(
      quizId: quizId,
      question: question,
    );

    switch (result) {
      case Success():
        state = state.loaded;
        break;
      case Failure(:final message):
        state = state.failed;
        error = message;
    }

    notifyListeners();
  }

  Future<void> updateQuestion({
    required String quizId,
    required Question question,
  }) async {
    state = state.loading;
    error = null;
    notifyListeners();

    final result = await _service.updateQuestion(
      quizId: quizId,
      question: question,
    );

    switch (result) {
      case Success():
        state = state.loaded;
        break;
      case Failure(:final message):
        state = state.failed;
        error = message;
    }

    notifyListeners();
  }

  Future<void> deleteQuestion({
    required String quizId,
    required String questionId,
  }) async {
    state = state.loading;
    error = null;
    notifyListeners();

    final result = await _service.deleteQuestion(
      quizId: quizId,
      questionId: questionId,
    );

    switch (result) {
      case Success():
        state = state.loaded;
        break;
      case Failure(:final message):
        state = state.failed;
        error = message;
    }

    notifyListeners();
  }
}
