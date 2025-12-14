import 'package:quiz/app/finite_state.dart';
import 'package:quiz/provider/teacher_provider.dart';

import '../../../commons.dart';
import 'card_question_editable.dart';

class TeacherQuestionForm extends StatefulWidget {
  final int level;
  final TeacherProvider provider;
  final ScrollController scrollControl;

  const TeacherQuestionForm({
    super.key,
    required this.level,
    required this.provider,
    required this.scrollControl,
  });

  @override
  State<TeacherQuestionForm> createState() => _TeacherQuestionFormState();
}

class _TeacherQuestionFormState extends State<TeacherQuestionForm> {
  final List<int> selectedAnswers = List.generate(3, (_) => -1);

  @override
  Widget build(BuildContext context) {
    var provider = widget.provider;
    var state = provider.state;

    if (state.isFirstTry) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.isFailed) {
      return Center(child: Text(provider.error ?? "Gagal ambil data"));
    }

    if (provider.questions.isEmpty) {
      return const Center(
        child: Text("Belum ada soal, silahkan tambahkan terlebih dahulu!"),
      );
    }

    return ListView.builder(
      controller: widget.scrollControl,
      itemCount: provider.questions.length,
      itemBuilder: (context, index) {
        final question = provider.questions[index];

        return TeacherQuestionCard(
          question: question,

          /// UPDATE LOCAL
          onChanged: (updated) {
            provider.updateQuestion(updated);
          },

          /// DELETE LOCAL
          onDelete: () {
            provider.deleteQuestion(question.id ?? "");
          },
        );
      },
    );
  }
}
