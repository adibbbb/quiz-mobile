import 'package:provider/provider.dart';
import '../../../commons.dart';
import '../../../provider/jawaban_siswa_provider.dart';
import '../../../provider/soal_guru_provider.dart';
import '../../../widgets/custom_button.dart';
import '../pages/siswa/pages/siswa_level_complate_view.dart';
import '../pages/siswa/pages/siswa_level_view.dart';

class SiswaPreviewAnswerView extends StatelessWidget {
  final int levelSiswa;
  final int questionIndex;
  final String bgImage;

  const SiswaPreviewAnswerView({
    super.key,
    required this.levelSiswa,
    required this.questionIndex,
    required this.bgImage,
  });

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentAnswerProvider>(context);
    final teacherProvider = Provider.of<TeacherQuestionProvider>(context);
    final question = teacherProvider.getQuestions(levelSiswa)[questionIndex];
    final userAnswer = studentProvider.getAnswer(level: levelSiswa, questionIndex: questionIndex);
    final correctAnswer = ['A','B','C','D'][question.selectedAnswerIndex];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(question.question, style: AppStyles.poppins24Medium),
            kGap20,
            ...List.generate(question.answers.length, (i) {
              final label = ['A','B','C','D'][i];
              Color bg = Colors.white;
              Color textColor = AppColors.black;
              if (label == correctAnswer) bg = AppColors.green;
              if (label == userAnswer && label != correctAnswer) bg = AppColors.red;
              return Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                padding: EdgeInsets.all(12),
                color: bg,
                child: Row(
                  children: [
                    Text('$label. ${question.answers[i]}', style: TextStyle(color: textColor)),
                  ],
                ),
              );
            }),
            kGap23,
            CustomButton(
              text: 'Next',
              backgroundColor: AppColors.green,
              onPressed: () {
                studentProvider.currentQuestionIndex++;
                final questions = teacherProvider.getQuestions(levelSiswa);
                if (studentProvider.currentQuestionIndex >= questions.length) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SiswaLevelComplateView(levelsiswa: levelSiswa),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SiswaLevelView(
                        levelSiswa: levelSiswa,
                        bgImage: bgImage,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
