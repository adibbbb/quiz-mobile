import 'package:quiz/widgets/custom_button.dart';

import '../../../commons.dart';

class SiswaPreviewAnswerView extends StatefulWidget {
  final int levelSiswa;
  final String bgImage;

  const SiswaPreviewAnswerView({
    super.key,
    required this.levelSiswa,
    required this.bgImage,
  });

  @override
  State<SiswaPreviewAnswerView> createState() => _SiswaPreviewAnswerViewState();
}

class _SiswaPreviewAnswerViewState extends State<SiswaPreviewAnswerView> {
  String? selectedAnswer;
  final String correctAnswer = 'B';
  final String userAnswer = 'D'; // misal dipilih user

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background
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
                              '"Ani pergi ke sekolah dengan berjalan kaki setiap pagi." Pertanyaan: Siapa yang pergi ke sekolah?',
                              style: AppStyles.poppins24Medium.copyWith(
                                fontSize: sizeQuestionText,
                              ),
                            ),
                            kGap43,
                            _buildAnswerOption(
                              'A',
                              'ASD',
                              selectedAnswer: userAnswer,
                              correctAnswer: correctAnswer,
                              isPreview: true,
                            ),
                            _buildAnswerOption(
                              'B',
                              'Ani',
                              selectedAnswer: userAnswer,
                              correctAnswer: correctAnswer,
                              isPreview: true,
                            ),
                            _buildAnswerOption(
                              'C',
                              'Budi',
                              selectedAnswer: userAnswer,
                              correctAnswer: correctAnswer,
                              isPreview: true,
                            ),
                            _buildAnswerOption(
                              'D',
                              'Sebew',
                              selectedAnswer: userAnswer,
                              correctAnswer: correctAnswer,
                              isPreview: true,
                            ),

                            kGap23,
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Jawaban bener : $correctAnswer',
                                    style: AppStyles.poppins24Medium.copyWith(
                                      fontSize: isTablet ? 20 : 16,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: CustomButton(
                                    text: 'Next',
                                    height: sizeButtonNext,
                                    backgroundColor: AppColors.green,
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Spacer(),

                      Image.asset(
                        AppImages.imgbgsoalLevel1,
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
    Color containerColor = Colors.white;
    Color circleBgColor = AppColors.blue;
    Color circleTextColor = Colors.white;
    Color textColor = AppColors.black;

    if (isPreview && selectedAnswer != null && correctAnswer != null) {
      if (label == selectedAnswer && label == correctAnswer) {
        // user jawab benar
        containerColor = AppColors.blue;
        circleBgColor = Colors.white;
        circleTextColor = AppColors.blue;
        textColor = Colors.white;
      } else if (label == selectedAnswer && label != correctAnswer) {
        // user jawab salah
        containerColor = AppColors.red;
        circleBgColor = Colors.white;
        circleTextColor = AppColors.red;
        textColor = Colors.white;
      } else if (label == correctAnswer) {
        // jawaban benar tapi tidak dipilih user
        containerColor = AppColors.green;
        circleBgColor = Colors.white;
        circleTextColor = AppColors.green;
        textColor = AppColors.white;
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
              // RadioButton user
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
              // Indikator jawaban benar di preview
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
