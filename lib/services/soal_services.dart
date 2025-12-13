import 'package:cloud_firestore/cloud_firestore.dart';
import '../provider/soal_guru_provider.dart';

class SoalService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Simpan atau update semua soal
  Future<void> saveOrUpdateQuestions({
    required List<QuestionData> questions,
    required int level,
    required String guruId,
  }) async {
    try {
      if (questions.isEmpty) return;

      final jawabanMap = ['a', 'b', 'c', 'd'];

      for (var q in questions) {
        if (q.selectedAnswerIndex < 0 || q.selectedAnswerIndex > 3) {
          throw Exception('Setiap soal harus memiliki jawaban yang benar');
        }

        final soalData = {
          "pertanyaan": q.question,
          "opsi": {
            "a": q.answers[0],
            "b": q.answers[1],
            "c": q.answers[2],
            "d": q.answers[3],
          },
          "jawaban": jawabanMap[q.selectedAnswerIndex],
          "guruId": guruId,
          "level": level,
          "timestamp": Timestamp.now(),
        };

        if (q.docId == null) {
          // Soal baru
          final docRef = await _firestore.collection('soal').add(soalData);
          q.docId = docRef.id; // simpan docId di provider
        } else {
          // Update soal lama
          await _firestore.collection('soal').doc(q.docId).update(soalData);
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
