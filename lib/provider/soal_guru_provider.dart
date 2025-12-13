import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/soal_services.dart';
import 'auth_provider.dart';

class TeacherQuestionProvider extends ChangeNotifier {
  // Menyimpan soal per level
  Map<int, List<QuestionData>> levelQuestions = {1: [], 2: [], 3: []};

  // Ambil soal per level
  List<QuestionData> getQuestions(int level) {
    return levelQuestions[level] ?? [];
  }

  Future<void> fetchQuestions(int level, String guruId) async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('soal')
              .where('guruId', isEqualTo: guruId)
              .where('level', isEqualTo: level)
              .get();

      final questions =
          snapshot.docs.map((doc) {
            final data = doc.data();
            return QuestionData(
              docId: doc.id,
              question: data['pertanyaan'] ?? '',
              answers: [
                data['opsi']?['a'] ?? '',
                data['opsi']?['b'] ?? '',
                data['opsi']?['c'] ?? '',
                data['opsi']?['d'] ?? '',
              ],
              selectedAnswerIndex: answerIndexFromString(data['jawaban'] ?? ''),
            );
          }).toList();

      levelQuestions[level] = questions;
      notifyListeners();
    } catch (e) {
      print("Error fetch questions: $e");
    }
  }

  // helper untuk ubah jawaban 'a','b','c','d' ke index
  int answerIndexFromString(String answer) {
    switch (answer) {
      case 'a':
        return 0;
      case 'b':
        return 1;
      case 'c':
        return 2;
      case 'd':
        return 3;
      default:
        return -1;
    }
  }

  void addQuestion(int level) {
    final q = QuestionData(
      question: '',
      answers: List.generate(4, (_) => ''),
      selectedAnswerIndex: -1,
    );
    levelQuestions[level]?.add(q);
    notifyListeners();
  }

  void updateQuestion(int level, int index, String text) {
    levelQuestions[level]?[index].question = text;
    notifyListeners();
  }

  void updateAnswer(int level, int qIndex, int aIndex, String text) {
    levelQuestions[level]?[qIndex].answers[aIndex] = text;
    notifyListeners();
  }

  void selectAnswer(int level, int qIndex, int aIndex) {
    levelQuestions[level]?[qIndex].selectedAnswerIndex = aIndex;
    notifyListeners();
  }

  Future<void> saveQuestions({
    required int level,
    required BuildContext context,
    required AuthProvider authProvider,
  }) async {
    final guruId = authProvider.loggedGuru?['id'];
    if (guruId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Guru belum login")));
      return;
    }

    final questions = getQuestions(level);
    if (questions.isEmpty) return;

    final service = SoalService();
    try {
      await service.saveOrUpdateQuestions(
        questions: questions,
        level: level,
        guruId: guruId,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua soal berhasil disimpan")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal menyimpan soal: $e")));
    }
  }

  Future<void> removeQuestionAt({
    required int level,
    required int index,
    required String guruId,
  }) async {
    final questions = getQuestions(level);
    if (index < 0 || index >= questions.length) return;

    final question = questions[index];
    try {
      if (question.docId != null && question.docId!.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('soal')
            .doc(question.docId)
            .delete();
      }
      questions.removeAt(index);
      notifyListeners();
    } catch (e) {
      print("Error hapus soal: $e");
    }
  }
}

// QuestionData sama seperti sebelumnya
class QuestionData {
  String? docId;
  String question;
  List<String> answers;
  int selectedAnswerIndex;

  final TextEditingController questionController;
  final List<TextEditingController> answerControllers;

  QuestionData({
    this.docId,
    required this.question,
    required this.answers,
    required this.selectedAnswerIndex,
  }) : questionController = TextEditingController(text: question),
       answerControllers = List.generate(
         answers.length,
         (i) => TextEditingController(text: answers[i]),
       );
}
