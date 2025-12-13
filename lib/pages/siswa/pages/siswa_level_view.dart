import '../../../app/custom_transition.dart';
import '../../../commons.dart';
import '../../../widgets/custom_button.dart';
import 'siswa_preview_jawaban_view.dart';

class SiswaLevelView extends StatefulWidget {
  final int levelSiswa;
  final String bgImage;

  const SiswaLevelView({
    super.key,
    required this.levelSiswa,
    required this.bgImage,
  });

  @override
  State<SiswaLevelView> createState() => _SiswaLevelViewState();
}

class _SiswaLevelViewState extends State<SiswaLevelView> {
  String? selectedAnswer;

  late final Color backgroundContainerColor;
  late final Color circleAvatarColor;
  late final Color buttonNextColor;

  @override
  void initState() {
    super.initState();
    _setColorsByLevel();
  }

  void _setColorsByLevel() {
    switch (widget.levelSiswa) {
      case 1:
        backgroundContainerColor = Colors.white;
        circleAvatarColor = AppColors.blue;
        buttonNextColor = AppColors.blue;
        break;
      case 2:
        backgroundContainerColor = Colors.white;
        circleAvatarColor = AppColors.orange;
        buttonNextColor = AppColors.orange;

        break;
      case 3:
        backgroundContainerColor = Colors.white;
        circleAvatarColor = AppColors.blueDongker;
        buttonNextColor = AppColors.blueDongker;

        break;
      default:
        backgroundContainerColor = Colors.white;
        circleAvatarColor = AppColors.blue;
        buttonNextColor = AppColors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                final double sizeButtonNext = isTablet ? 70 : 55;

                return Container(
                  height: screenHeight * 0.75,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: backgroundContainerColor,
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
                              backgroundColor: buttonNextColor,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  SlidePageRoute(
                                    page: SiswaPreviewAnswerView(
                                      levelSiswa: widget.levelSiswa,
                                      bgImage: AppImages.imgBgLevel1,
                                    ),
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
              color: isSelected ? circleAvatarColor : backgroundContainerColor,
              borderRadius: kRadius42,
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
                  backgroundColor:
                      isSelected ? Colors.white : circleAvatarColor,
                  child: Text(
                    label,
                    style: AppStyles.poppins24Medium.copyWith(
                      fontSize: sizeRadioButtonText,
                      color: isSelected ? circleAvatarColor : Colors.white,
                    ),
                  ),
                ),
                kGap16,
                Expanded(
                  child: Text(
                    text,
                    style: AppStyles.poppins24Medium.copyWith(
                      fontSize: sizeRadioButtonText,
                      color: isSelected ? Colors.white : AppColors.black,
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
