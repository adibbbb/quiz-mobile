import 'package:flutter/material.dart';

class TeacherQuestionProvider extends ChangeNotifier {
  List<QuestionData> questions = [];

  void addQuestion() {
    questions.add(
      QuestionData(
        question: '',
        answers: List.generate(4, (_) => ''),
        selectedAnswerIndex: -1,
      ),
    );
    notifyListeners();
  }

  void removeQuestion(int index) {
    if (index >= 0 && index < questions.length) {
      questions.removeAt(index);
      notifyListeners();
    }
  }

  void updateQuestion(int index, String text) {
    questions[index].question = text;
    notifyListeners();
  }

  void updateAnswer(int qIndex, int aIndex, String text) {
    questions[qIndex].answers[aIndex] = text;
    notifyListeners();
  }

  void selectAnswer(int qIndex, int aIndex) {
    questions[qIndex].selectedAnswerIndex = aIndex;
    notifyListeners();
  }
}

class QuestionData {
  String question;
  List<String> answers;
  int selectedAnswerIndex;

  QuestionData({
    required this.question,
    required this.answers,
    required this.selectedAnswerIndex,
  });
}
