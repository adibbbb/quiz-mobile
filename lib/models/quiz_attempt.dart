class QuizAttempt {
  final String quizId;
  final int level;
  final String userId;
  final int score;
  final int time;
  final DateTime completedAt;

  QuizAttempt({
    required this.quizId,
    required this.level,
    required this.userId,
    required this.score,
    required this.time,
    required this.completedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'quizId': quizId,
      'level': level,
      'userId': userId,
      'score': score,
      'time': time,
      'completedAt': completedAt,
    };
  }
}
