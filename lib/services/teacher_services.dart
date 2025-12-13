import 'package:cloud_firestore/cloud_firestore.dart';

import '../app/result.dart';
import '../models/question.dart';
import '../models/quiz.dart';

class TeacherService {
  final FirebaseFirestore _db;

  TeacherService({FirebaseFirestore? db})
    : _db = db ?? FirebaseFirestore.instance;

  /// Create / Update quiz (level)
  ResultFuture<void> saveQuiz(Quiz quiz) async {
    try {
      await _db.collection('quizzes').doc(quiz.id).set({
        'title': quiz.title,
        'level': quiz.level,
        'timeLimit': quiz.timeLimit,
        'totalQuestions': quiz.totalQuestions,
        'isPublished': true,
      });

      return const Success(null);
    } catch (_) {
      return const Failure('Gagal menyimpan quiz');
    }
  }

  /// Tambah soal ke quiz
  ResultFuture<void> addQuestion({
    required String quizId,
    required Question question,
  }) async {
    try {
      await _db.collection('quizzes').doc(quizId).collection('questions').add({
        'question': question.question,
        'options': question.options,
        'correctAnswer': question.correctAnswer,
        'score': question.score,
      });

      return const Success(null);
    } catch (_) {
      return const Failure('Gagal menambahkan soal');
    }
  }

  /// Update soal
  ResultFuture<void> updateQuestion({
    required String quizId,
    required Question question,
  }) async {
    try {
      await _db
          .collection('quizzes')
          .doc(quizId)
          .collection('questions')
          .doc(question.id)
          .update({
            'question': question.question,
            'options': question.options,
            'correctAnswer': question.correctAnswer,
            'score': question.score,
          });

      return const Success(null);
    } catch (_) {
      return const Failure('Gagal memperbarui soal');
    }
  }

  /// Hapus soal
  ResultFuture<void> deleteQuestion({
    required String quizId,
    required String questionId,
  }) async {
    try {
      await _db
          .collection('quizzes')
          .doc(quizId)
          .collection('questions')
          .doc(questionId)
          .delete();

      return const Success(null);
    } catch (_) {
      return const Failure('Gagal menghapus soal');
    }
  }
}
