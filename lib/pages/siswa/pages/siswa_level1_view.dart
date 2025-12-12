import 'package:quiz/app/custom_transition.dart';
import 'package:quiz/widgets/custom_button.dart';

import '../../../commons.dart';
import 'siswa_level_complate_view.dart';

class SiswaLevel1View extends StatefulWidget {
  const SiswaLevel1View({super.key});

  @override
  State<SiswaLevel1View> createState() => _SiswaLevel1ViewState();
}

class _SiswaLevel1ViewState extends State<SiswaLevel1View> {
  String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.imgBgLevel1),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 40,
                ),
                child: Column(children: [_appBar()]),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bool isTablet = constraints.maxWidth >= 600;
                final double sizeQuestionText = isTablet ? 24 : 16;
                final double sizeButtonNext = isTablet ? 70 : 55;

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
                            _buildAnswerOption('A', 'Aran'),
                            kGap16,
                            _buildAnswerOption('B', 'Ani'),
                            kGap16,
                            _buildAnswerOption('C', 'Budi'),
                            kGap16,
                            _buildAnswerOption('D', 'Sebew'),
                            kGap23,
                            CustomButton(
                              text: 'Next',
                              height: sizeButtonNext,
                              backgroundColor: AppColors.blue,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  SlidePageRoute(
                                    page: SiswaLevelComplateView(),
                                  ),
                                );
                              },
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

  Widget _buildAnswerOption(String label, String text) {
    bool isSelected = selectedAnswer == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAnswer = label;
        });
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isTablet = constraints.maxWidth >= 600;
          final double sizeRadioButtonText = isTablet ? 24 : 16;
          final EdgeInsetsDirectional paddingButton =
              isTablet
                  ? EdgeInsetsDirectional.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  )
                  : EdgeInsetsDirectional.symmetric(horizontal: 4, vertical: 3);

          return Container(
            padding: paddingButton,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.blue : Colors.white,
              borderRadius: kRadius42,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  // ignore: deprecated_member_use
                  color: Color(0xff000000).withOpacity(0.1),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: isSelected ? Colors.white : AppColors.blue,
                  child: Text(
                    label,
                    style: AppStyles.poppins24Medium.copyWith(
                      fontSize: sizeRadioButtonText,
                      color: isSelected ? AppColors.blue : Colors.white,
                    ),
                  ),
                ),
                kGap16,
                Expanded(
                  child: Text(
                    text,
                    style: AppStyles.poppins24Medium.copyWith(
                      fontSize: sizeRadioButtonText,
                      color: isSelected ? Colors.white : AppColors.blue,
                    ),
                  ),
                ),
                Radio<String>(
                  activeColor: Colors.white,
                  value: label,
                  groupValue: selectedAnswer,
                  onChanged: (value) {
                    setState(() {
                      selectedAnswer = value;
                    });
                  },
                ),
              ],
            ),
          );
        },
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
          'LEVEL 1',
          style: AppStyles.lilitaOne42.copyWith(color: AppColors.white),
        ),
        kGap25,
      ],
    );
  }
}
