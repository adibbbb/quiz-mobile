import 'package:cloud_firestore/cloud_firestore.dart';

import '../app/result.dart';
import '../models/question.dart';
import '../models/quiz.dart';
import '../models/quiz_attempt.dart';

class QuizService {
  final FirebaseFirestore _db;

  QuizService({FirebaseFirestore? db}) : _db = db ?? FirebaseFirestore.instance;

  /// Ambil semua quiz yang sudah publish
  ResultFuture<List<Quiz>> fetchQuizzes() async {
    try {
      final snapshot =
          await _db
              .collection('quizzes')
              .where('isPublished', isEqualTo: true)
              .orderBy('level')
              .get();

      final quizzes =
          snapshot.docs.map((doc) => Quiz.fromMap(doc.id, doc.data())).toList();

      return Success(quizzes);
    } catch (_) {
      return const Failure('Gagal mengambil data quiz');
    }
  }

  /// Ambil soal (±20 soal) dari quiz
  ResultFuture<List<Question>> fetchQuestions(String quizId) async {
    try {
      final snapshot =
          await _db
              .collection('quizzes')
              .doc(quizId)
              .collection('questions')
              .get();

      final questions =
          snapshot.docs
              .map((doc) => Question.fromMap(doc.id, doc.data()))
              .toList();

      return Success(questions);
    } catch (_) {
      return const Failure('Gagal mengambil soal');
    }
  }

  /// Submit hasil quiz
  ResultFuture<void> submitAttempt({
    required QuizAttempt attempt,
    required String userName,
  }) async {
    try {
      final batch = _db.batch();

      // 1️⃣ Simpan attempt
      final attemptRef = _db.collection('quiz_attempts').doc();
      batch.set(attemptRef, attempt.toMap());

      // 2️⃣ Update leaderboard
      final leaderboardRef = _db
          .collection('leaderboards')
          .doc(attempt.quizId)
          .collection('entries')
          .doc(attempt.userId);

      batch.set(leaderboardRef, {
        'name': userName,
        'score': attempt.score,
        'time': attempt.time,
        'submittedAt': FieldValue.serverTimestamp(),
      });

      await batch.commit();
      return const Success(null);
    } catch (_) {
      return const Failure('Gagal menyimpan hasil quiz');
    }
  }

  ResultFuture<void> syncQuestions({
    required String quizId,
    required List<Question> questions,
    required List<String> deletedQuestionIds,
  }) async {
    try {
      final batch = _db.batch();
      final collection = _db
          .collection('quizzes')
          .doc(quizId)
          .collection('questions');

      /// DELETE
      for (final id in deletedQuestionIds) {
        batch.delete(collection.doc(id));
      }

      /// ADD + UPDATE (AMAN)
      for (final q in questions) {
        final doc =
            (q.id == null || q.id!.isEmpty)
                ? collection
                    .doc() // soal baru
                : collection.doc(q.id!); // soal lama

        batch.set(doc, q.copyWith(id: doc.id).toMap(), SetOptions(merge: true));
      }

      await batch.commit();
      return const Success(null);
    } catch (e) {
      return const Failure('Gagal menyimpan perubahan soal');
    }
  }

  // ==========================================================
  // SECTION: LEADERBOARD
  // ==========================================================

  /// Ambil leaderboard per quizId / level
  ResultFuture<List<QuizAttempt>> getLeaderboard(
    String quizId, {
    int limit = 100,
  }) async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('quiz_attempts')
              .where('quizId', isEqualTo: quizId)
              .orderBy('score', descending: true) // skor tertinggi di atas
              .orderBy(
                'completedAt',
                descending: false,
              ) // jika sama skor, siapa selesai duluan
              .limit(limit)
              .get();

      final attempts =
          snapshot.docs.map((doc) => QuizAttempt.fromMap(doc.data())).toList();

      return Success(attempts);
    } catch (e) {
      return Failure('Gagal mengambil leaderboard: ${e.toString()}');
    }
  }
}
