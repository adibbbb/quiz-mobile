class Quiz {
  final String id;
  final String title;
  final int level;
  final int timeLimit;
  final int totalQuestions;

  Quiz({
    required this.id,
    required this.title,
    required this.level,
    required this.timeLimit,
    required this.totalQuestions,
  });

  factory Quiz.fromMap(String id, Map<String, dynamic> data) {
    return Quiz(
      id: id,
      title: data['title'] as String,
      level: data['level'] as int,
      timeLimit: data['time_limit'] as int,
      totalQuestions: data['total_questions'] as int,
    );
  }
}
