class Question {
  final String? id;
  final String question;
  final List<String> options;
  final int correctAnswer;

  Question({
    this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
    };
  }

  factory Question.fromMap(String id, Map<String, dynamic> data) {
    return Question(
      id: id,
      question: data['question'] as String,
      options: List<String>.from(data['options']),
      correctAnswer: data['correctAnswer'] as int,
    );
  }

  Question copyWith({
    String? id,
    String? question,
    List<String>? options,
    int? correctAnswer,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      options: options ?? this.options,
      correctAnswer: correctAnswer ?? this.correctAnswer,
    );
  }
}
