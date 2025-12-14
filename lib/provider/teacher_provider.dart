import 'package:quiz/app/extensions.dart';
import 'package:quiz/app/navigator_keys.dart';
import 'package:quiz/services/quizz_services.dart';

import '../app/finite_state.dart';
import '../commons.dart';
import '../models/question.dart';

class TeacherProvider extends ChangeNotifier {
  final QuizService _service;

  TeacherProvider(this._service);

  MyState state = MyState.initial;
  String? error;

  // ===== QUESTION EDITOR =====
  List<Question> questions = [];
  final List<String> _deletedQuestionIds = [];

  // ===============================
  // FETCH QUESTIONS PER QUIZ
  // ===============================
  Future<void> fetchQuestions(String quizId) async {
    state = MyState.loading;
    error = null;
    notifyListeners();
    final result = await _service.fetchQuestions(quizId);
    result.when(
      success: (data) {
        questions = data;
        _deletedQuestionIds.clear();
        state = MyState.loaded;
      },
      failure: (message) {
        state = MyState.failed;
        error = message;
      },
    );

    notifyListeners();
  }

  // ===============================
  // LOCAL QUESTION ACTIONS
  // ===============================
  void addQuestion(Question question) {
    questions.add(question);
    notifyListeners();
  }

  void updateQuestion(Question question) {
    final index = questions.indexWhere((q) => q.id == question.id);
    if (index != -1) {
      questions[index] = question;
      notifyListeners();
    }
  }

  void deleteQuestion(String questionId) {
    final index = questions.indexWhere((q) => q.id == questionId);
    if (index == -1) return;

    if ((questions[index].id ?? "").isNotEmpty) {
      _deletedQuestionIds.add(questionId);
    }

    questions.removeAt(index);
    notifyListeners();
  }

  // ===============================
  // SAVE ALL CHANGES
  // ===============================
  Future<bool> saveAll({required String quizId}) async {
    state = MyState.loading;
    error = null;
    notifyListeners();

    final result = await _service.syncQuestions(
      quizId: quizId,
      questions: questions,
      deletedQuestionIds: _deletedQuestionIds,
    );

    bool isSaved = false;

    result.when(
      success: (data) {
        isSaved = true;
        _deletedQuestionIds.clear();
        state = MyState.loaded;
        navigatorKey.currentContext?.showSuccessSnackBar(
          "Berhasil menyimpan perubahan!",
        );
      },
      failure: (message) {
        isSaved = false;
        state = MyState.loaded;

        error = message;
        navigatorKey.currentContext?.showErrorSnackBar(
          "Gagal menyimpan perubahan!",
        );
      },
    );

    notifyListeners();
    return isSaved;
  }

  void cancelEdit() {
    _deletedQuestionIds.clear();
    state = MyState.initial;
    error = null;
  }
}
