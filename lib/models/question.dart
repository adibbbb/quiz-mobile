class Question {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswer;
  final int score;

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.score,
  });

  factory Question.fromMap(String id, Map<String, dynamic> data) {
    return Question(
      id: id,
      question: data['question'] as String,
      options: List<String>.from(data['options']),
      correctAnswer: data['correctAnswer'] as int,
      score: data['score'] as int,
    );
  }
}
