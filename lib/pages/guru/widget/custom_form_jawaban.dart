import 'package:provider/provider.dart';
import '../../../commons.dart';
import '../../../provider/pertanyaan_guru_provider.dart';

class TeacherQuestionForm extends StatelessWidget {
  const TeacherQuestionForm({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<TeacherQuestionProvider>(context);

    return ListView.builder(
      itemCount: prov.questions.length,
      itemBuilder: (context, index) {
        final question = prov.questions[index];
        return TeacherQuestionCard(
          questionData: question,
          onDelete: () => prov.removeQuestion(index),
          onQuestionChanged: (text) => prov.updateQuestion(index, text),
          onAnswerChanged:
              (aIndex, text) => prov.updateAnswer(index, aIndex, text),
          onSelectAnswer: (aIndex) => prov.selectAnswer(index, aIndex),
        );
      },
    );
  }
}

class TeacherQuestionCard extends StatelessWidget {
  final QuestionData questionData;
  final VoidCallback onDelete;
  final ValueChanged<String> onQuestionChanged;
  final void Function(int, String) onAnswerChanged;
  final ValueChanged<int> onSelectAnswer;

  const TeacherQuestionCard({
    super.key,
    required this.questionData,
    required this.onDelete,
    required this.onQuestionChanged,
    required this.onAnswerChanged,
    required this.onSelectAnswer,
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

          // Jawaban
          Column(
            children: List.generate(questionData.answers.length, (i) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Radio<int>(
                      value: i,
                      groupValue: questionData.selectedAnswerIndex,
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
          kGap8,

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
