import 'package:quiz/widgets/custom_button.dart';

import '../../../commons.dart';

class SiswaLevel3View extends StatefulWidget {
  const SiswaLevel3View({super.key});

  @override
  State<SiswaLevel3View> createState() => _SiswaLevel3ViewState();
}

class _SiswaLevel3ViewState extends State<SiswaLevel3View> {
  // state untuk menyimpan jawaban yang dipilih
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
                image: AssetImage(AppImages.imgBgLevel3),
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

          // White Container dari bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
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
                  // Bagian atas dengan padding untuk teks dan jawaban
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
                          style: AppStyles.poppins24Medium,
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
                          onPressed: () {},
                          text: 'Next',
                          backgroundColor: AppColors.blueDongker,
                        ),
                      ],
                    ),
                  ),

                  Spacer(),

                  Image.asset(
                    AppImages.imgbgsoalLevel3,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget opsi jawaban dengan radio
  Widget _buildAnswerOption(String label, String text) {
    bool isSelected = selectedAnswer == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAnswer = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.blueDongker : Colors.white,
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
              backgroundColor: isSelected ? Colors.white : AppColors.blueDongker,
              child: Text(
                label,
                style: AppStyles.poppins24Medium.copyWith(
                  color: isSelected ? AppColors.blueDongker : Colors.white,
                ),
              ),
            ),
            kGap16,
            Expanded(
              child: Text(
                text,
                style: AppStyles.poppins24Medium.copyWith(
                  color: isSelected ? Colors.white : AppColors.blueDongker,
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
          'LEVEL 3',
          style: AppStyles.lilitaOne42.copyWith(color: AppColors.white),
        ),
        kGap25,
      ],
    );
  }
}
