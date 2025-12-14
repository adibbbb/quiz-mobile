import '../../../commons.dart';

class TeacherQuestionForm extends StatefulWidget {
  final int level;

  const TeacherQuestionForm({super.key, required this.level});

  @override
  State<TeacherQuestionForm> createState() => _TeacherQuestionFormState();
}

class _TeacherQuestionFormState extends State<TeacherQuestionForm> {
  final List<int> selectedAnswers = List.generate(3, (_) => -1);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return TeacherQuestionCard(
          selectedAnswer: selectedAnswers[index],
          onQuestionChanged: (text) {
            // simpan soal kalau mau
          },
          onSelectAnswer: (answerIndex) {
            setState(() {
              selectedAnswers[index] = answerIndex;
            });
          },
          onAnswerChanged: (index, text) {
            // simpan opsi jawaban
          },
          onDelete: () {},
        );
      },
    );
  }
}

class TeacherQuestionCard extends StatelessWidget {
  // final QuestionData questionData;
  final VoidCallback onDelete;
  final ValueChanged<String> onQuestionChanged;
  final void Function(int, String) onAnswerChanged;
  final ValueChanged<int> onSelectAnswer;
  final int selectedAnswer;

  const TeacherQuestionCard({
    super.key,
    // required this.questionData,
    required this.onDelete,
    required this.onQuestionChanged,
    required this.onAnswerChanged,
    required this.onSelectAnswer,
    required this.selectedAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(2, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TextField Soal
          TextField(
            onChanged: onQuestionChanged,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Tulis soal di sini...',
            ),
            maxLines: null,
          ),
          const Divider(),

          Column(
            children: List.generate(4, (i) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    // jawaban radio
                    Radio<int>(
                      value: i,
                      groupValue: selectedAnswer,
                      activeColor: Colors.red,
                      onChanged: (value) => onSelectAnswer(i),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        onChanged: (text) => onAnswerChanged(i, text),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Opsi ${i + 1}',
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const Divider(),
          SizedBox(height: 8),

          // Hapus
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onDelete,
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.redAccent,
                  size: 28,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
