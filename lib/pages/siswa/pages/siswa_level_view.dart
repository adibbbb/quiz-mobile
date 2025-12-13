import 'package:provider/provider.dart';
import 'package:quiz/app/finite_state.dart';
import 'package:quiz/provider/authentication_provider.dart';
import 'package:quiz/provider/quiz_provider.dart';

import '../../../commons.dart';
import '../../../widgets/custom_button.dart';
import '../widgets/answer_options.dart';

class SiswaLevelView extends StatefulWidget {
  final int levelSiswa;
  final String bgImage;
  final String? imgBgLevel;

  const SiswaLevelView({
    super.key,
    required this.levelSiswa,
    required this.bgImage,
    this.imgBgLevel,
  });

  @override
  State<SiswaLevelView> createState() => _SiswaLevelViewState();
}

class _SiswaLevelViewState extends State<SiswaLevelView> {
  late Color bgCardColor;
  late Color selectedColor;
  late Color buttonNextColor;

  void _setColorsByLevel() {
    switch (widget.levelSiswa) {
      case 1:
        bgCardColor = Colors.white;
        selectedColor = AppColors.blue;
        buttonNextColor = AppColors.blue;
        break;
      case 2:
        bgCardColor = Colors.white;
        selectedColor = AppColors.orange;
        buttonNextColor = AppColors.orange;
        break;
      case 3:
        bgCardColor = Colors.white;
        selectedColor = AppColors.blueDongker;
        buttonNextColor = AppColors.blueDongker;
        break;
      default:
        bgCardColor = Colors.white;
        selectedColor = AppColors.blue;
        buttonNextColor = AppColors.blue;
    }
  }

  @override
  void initState() {
    super.initState();
    _setColorsByLevel();

    // ambil soal
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var prov = context.read<QuizProvider>();
      prov.fetchQuestions("quiz_${widget.levelSiswa}");
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProv = context.read<AuthenticationProvider>();
    return Scaffold(
      body: Stack(
        children: [
          _backgroundLevel(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgCardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Consumer<QuizProvider>(
                builder: (context, prov, _) {
                  var state = prov.state;
                  if (state.isFirstTry) {
                    return Container(
                      height: 20,
                      width: 20,
                      color: Colors.white,
                      child: UnconstrainedBox(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state.isFailed) return Text("Gagal load questions");

                  // Semua soal sudah di-load
                  if (prov.questions.isEmpty) {
                    return const Center(child: Text('Tidak ada soal'));
                  }
                  final currentQuestion =
                      prov.questions[prov.currentQuestionIndex];

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 32,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentQuestion.question,

                              style: AppStyles.poppins24Medium,
                            ),
                            kGap20,
                            ...List.generate(currentQuestion.options.length, (
                              index,
                            ) {
                              final label = ['A', 'B', 'C', 'D'][index];

                              return AnswerOption(
                                label: label,
                                text: currentQuestion.options[index],
                                isSelected: index == prov.selectedAnswerIndex,
                                showCorrectAnswer: prov.showCorrectAnswer,
                                isCorrect:
                                    index == currentQuestion.correctAnswer,
                                onTap: () => prov.selectAnswer(index),
                                selectedColor:
                                    selectedColor, // bisa ambil dari level
                                backgroundColor: bgCardColor,
                              );
                            }),

                            kGap23,
                            CustomButton(
                              text: 'Next',
                              backgroundColor: buttonNextColor,
                              onPressed: () {
                                prov.selectedAnswerIndex != null
                                    ? prov.nextQuestion(
                                      authProv.user!,
                                      widget.levelSiswa,
                                    )
                                    : null; // disable button kalau belum pilih jawaban
                              },
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Image.asset(
                        widget.imgBgLevel.toString(),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _backgroundLevel() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.bgImage),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: _appBar(),
        ),
      ),
    );
  }

  Row _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.white,
            size: 25,
          ),
        ),
        Text(
          'LEVEL ${widget.levelSiswa}',
          style: AppStyles.lilitaOne42.copyWith(color: AppColors.white),
        ),
        kGap25,
      ],
    );
  }
}
