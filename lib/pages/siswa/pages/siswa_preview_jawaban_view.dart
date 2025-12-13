import '../../../commons.dart';
import '../../../widgets/custom_button.dart';
import '../widgets/level_colors.dart';

class SiswaPreviewAnswerView extends StatefulWidget {
  final int levelSiswa;
  final int questionIndex;
  final String bgImage;

  const SiswaPreviewAnswerView({
    super.key,
    required this.levelSiswa,
    required this.bgImage,
    required this.questionIndex,
  });

  @override
  State<SiswaPreviewAnswerView> createState() => _SiswaPreviewAnswerViewState();
}

class _SiswaPreviewAnswerViewState extends State<SiswaPreviewAnswerView> {
  @override
  Widget build(BuildContext context) {
    // final studentProvider = Provider.of<StudentAnswerProvider>(context);
    // final teacherProvider = Provider.of<TeacherQuestionProvider>(context);

    // final question =
    //     teacherProvider.getQuestions(widget.levelSiswa)[widget.questionIndex];

    // final userAnswer = studentProvider.getAnswer(
    //   level: widget.levelSiswa,
    //   questionIndex: widget.questionIndex,
    // );

    // final correctAnswer = ['A', 'B', 'C', 'D'][question.selectedAnswerIndex];

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          _backgroundLevel(),
          Align(
            alignment: Alignment.bottomCenter,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bool isTablet = constraints.maxWidth >= 600;
                final double sizeQuestionText = isTablet ? 24 : 16;
                final double sizeButtonNext = isTablet ? 60 : 55;

                return Container(
                  height: screenHeight * 0.75,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
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
                              "question.question",
                              style: AppStyles.poppins24Medium.copyWith(
                                fontSize: sizeQuestionText,
                              ),
                            ),
                            kGap43,
                            // ...List.generate(4, (i) {
                            //   final label = ['A', 'B', 'C', 'D'][i];
                            //   final answerText = question.answers[i];
                            //   return _buildAnswerOption(
                            //     label,
                            //     answerText,
                            //     selectedAnswer: userAnswer,
                            //     correctAnswer: correctAnswer,
                            //     isPreview: true,
                            //   );
                            // }),
                            kGap23,
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Jawaban bener : ADSSAD',
                                    style: AppStyles.poppins24Medium.copyWith(
                                      fontSize: isTablet ? 20 : 16,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: CustomButton(
                                    text: 'Next',
                                    height: sizeButtonNext,
                                    backgroundColor: LevelColors.getButtonNext(
                                      widget.levelSiswa,
                                    ),
                                    onPressed: () {
                                      //   final studentProvider =
                                      //       Provider.of<StudentAnswerProvider>(
                                      //         context,
                                      //         listen: false,
                                      //       );
                                      //   studentProvider.currentQuestionIndex++;

                                      //   final totalQuestions =
                                      //       teacherProvider
                                      //           .getQuestions(widget.levelSiswa)
                                      //           .length;

                                      //   if (studentProvider
                                      //           .currentQuestionIndex >=
                                      //       totalQuestions) {
                                      //     // Semua soal selesai → LevelComplete
                                      //     Navigator.pushReplacement(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //         builder:
                                      //             (_) => SiswaLevelComplateView(
                                      //               levelsiswa: widget.levelSiswa,
                                      //             ),
                                      //       ),
                                      //     );
                                      //   } else {
                                      //     // Lanjut ke soal berikutnya
                                      //     Navigator.pushReplacement(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //         builder:
                                      //             (_) => SiswaLevelView(
                                      //               levelSiswa: widget.levelSiswa,
                                      //               bgImage: widget.bgImage,
                                      //             ),
                                      //       ),
                                      //     );
                                      //   }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Image.asset(
                        LevelColors.getImgBgLevel(widget.levelSiswa.toString()),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerOption(
    String label,
    String text, {
    String? selectedAnswer,
    String? correctAnswer,
    bool isPreview = false,
  }) {
    // Ambil warna default berdasarkan level
    Color containerColor = LevelColors.getBackground(widget.levelSiswa);
    Color circleBgColor = LevelColors.getCircleAvatar(widget.levelSiswa);
    Color circleTextColor = Colors.white;
    Color textColor = AppColors.black;

    if (isPreview && selectedAnswer != null && correctAnswer != null) {
      if (label == selectedAnswer && label == correctAnswer) {
        // User jawab benar
        containerColor = LevelColors.getCircleAvatar(widget.levelSiswa);
        circleBgColor = Colors.white;
        circleTextColor = LevelColors.getCircleAvatar(widget.levelSiswa);
        textColor = Colors.white;
      } else if (label == selectedAnswer && label != correctAnswer) {
        // User jawab salah
        containerColor = AppColors.red;
        circleBgColor = Colors.white;
        circleTextColor = AppColors.red;
        textColor = Colors.white;
      } else if (label == correctAnswer) {
        // Jawaban benar tapi tidak dipilih user
        containerColor = AppColors.green;
        circleBgColor = Colors.white;
        circleTextColor = AppColors.green;
        textColor = Colors.white;
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isTablet = constraints.maxWidth >= 600;
        final double sizeRadioButtonText = isTablet ? 24 : 16;
        final EdgeInsetsDirectional paddingButton =
            isTablet
                ? EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12)
                : EdgeInsetsDirectional.symmetric(horizontal: 4, vertical: 3);

        return Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          padding: paddingButton,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(42),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 4),
                color: Color(0xff000000).withOpacity(0.1),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: circleBgColor,
                child: Text(
                  label,
                  style: AppStyles.poppins24Medium.copyWith(
                    fontSize: sizeRadioButtonText,
                    color: circleTextColor,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: AppStyles.poppins24Medium.copyWith(
                    fontSize: sizeRadioButtonText,
                    color: textColor,
                  ),
                ),
              ),
              if (!isPreview)
                Radio<String>(
                  value: label,
                  groupValue: selectedAnswer,
                  onChanged: (value) {
                    setState(() {
                      selectedAnswer = value;
                    });
                  },
                ),
              if (isPreview)
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        label == correctAnswer
                            ? Colors.green
                            : Colors.transparent,
                    border: Border.all(
                      color:
                          label == correctAnswer ? Colors.green : Colors.grey,
                      width: 2,
                    ),
                  ),
                  child:
                      label == correctAnswer
                          ? Icon(Icons.check, color: Colors.white, size: 14)
                          : null,
                ),
            ],
          ),
        );
      },
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
          child: Column(children: [_appBar()]),
        ),
      ),
    );
  }

  Row _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
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
