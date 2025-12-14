// ignore_for_file: deprecated_member_use

import '../../../commons.dart';
import '../../../models/question.dart';

class TeacherQuestionCard extends StatefulWidget {
  final Question question;

  final VoidCallback onDelete;
  final ValueChanged<Question> onChanged;

  const TeacherQuestionCard({
    super.key,
    required this.question,
    required this.onDelete,
    required this.onChanged,
  });

  @override
  State<TeacherQuestionCard> createState() => _TeacherQuestionCardState();
}

class _TeacherQuestionCardState extends State<TeacherQuestionCard> {
  late TextEditingController questionController;
  late List<TextEditingController> optionControllers;

  @override
  void initState() {
    super.initState();

    questionController = TextEditingController(text: widget.question.question);

    optionControllers =
        widget.question.options
            .map((e) => TextEditingController(text: e))
            .toList();
  }

  @override
  void didUpdateWidget(covariant TeacherQuestionCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.question != widget.question) {
      questionController.text = widget.question.question;

      for (int i = 0; i < optionControllers.length; i++) {
        optionControllers[i].text = widget.question.options[i];
      }
    }
  }

  @override
  void dispose() {
    questionController.dispose();
    for (final c in optionControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.question;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black.withAlpha(50),
            offset: const Offset(2, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// QUESTION
          TextField(
            controller: questionController,
            onChanged: (value) {
              widget.onChanged(question.copyWith(question: value));
            },
            decoration: const InputDecoration(
              hintText: 'Tulis soal di sini...',
              border: InputBorder.none,
            ),
          ),

          const Divider(),

          /// OPTIONS
          Column(
            children: List.generate(optionControllers.length, (i) {
              return Row(
                children: [
                  Radio<int>(
                    activeColor: AppColors.black,
                    value: i,
                    groupValue: question.correctAnswer,

                    onChanged: (_) {
                      widget.onChanged(question.copyWith(correctAnswer: i));
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: optionControllers[i],
                      onChanged: (text) {
                        final updated = [...question.options];
                        updated[i] = text;
                        widget.onChanged(question.copyWith(options: updated));
                      },
                      decoration: InputDecoration(
                        hintText: 'Opsi ${i + 1}',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),

          const Divider(),

          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: widget.onDelete,
              child: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
