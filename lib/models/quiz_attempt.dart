import 'package:cloud_firestore/cloud_firestore.dart';

class QuizAttempt {
  final String? quizId;
  final int? level;
  final String? userId;
  final String? userName;
  final int? score;
  final int? time;
  final DateTime? completedAt;

  QuizAttempt({
    this.quizId,
    this.level,
    this.userId,
    this.userName,
    this.score,
    this.time,
    this.completedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      if (quizId != null) 'quizId': quizId,
      if (level != null) 'level': level,
      if (userId != null) 'userId': userId,
      if (userName != null) 'userName': userName,
      if (score != null) 'score': score,
      if (time != null) 'time': time,
      if (completedAt != null) 'completedAt': completedAt,
    };
  }

  factory QuizAttempt.fromMap(Map<String, dynamic> map) {
    return QuizAttempt(
      quizId: map['quizId'],
      level: map['level'],
      userId: map['userId'],
      userName: map['userName'],
      score: map['score'],
      time: map['time'],
      completedAt:
          map['completedAt'] != null
              ? (map['completedAt'] as Timestamp).toDate()
              : null,
    );
  }
}
