import 'dart:ui';

import '../../../app/custom_transition.dart';
import '../../../commons.dart';
import '../../../widgets/custom_button.dart';
import '../../guru/pages/leaderboard_view.dart';
import 'siswa_home_view.dart';

class SiswaLevelComplateView extends StatefulWidget {
  final int levelsiswa;
  const SiswaLevelComplateView({super.key, required this.levelsiswa});

  @override
  State<SiswaLevelComplateView> createState() => _SiswaLevelComplateViewState();
}

class _SiswaLevelComplateViewState extends State<SiswaLevelComplateView> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Ambil provider

    // Ambil data soal & jawaban
    // final level = widget.levelsiswa;
    // final questions = teacherProvider.getQuestions(level);
    // final correctAnswers =
    //     questions
    //         .map((q) => ['A', 'B', 'C', 'D'][q.selectedAnswerIndex])
    //         .toList();
    // final scoreRaw = studentProvider.correctAnswersCount(level, correctAnswers);
    // final total = questions.length;

    // final scorePercent = total > 0 ? ((scoreRaw / total) * 100).round() : 0;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.imgBgHome),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Blur effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.black.withOpacity(0)),
            ),
          ),

          Center(
            child: Container(
              width: screenWidth * 0.85,
              height: screenHeight * 0.85,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(73),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final bool isTablet = constraints.maxWidth >= 600;
                  final double sizeFontText = isTablet ? 64 : 40;
                  final EdgeInsetsGeometry padding =
                      isTablet
                          ? EdgeInsets.fromLTRB(50, 100, 50, 50)
                          : EdgeInsets.all(50);
                  return Padding(
                    padding: padding,
                    child: Column(
                      children: [
                        Image.asset(
                          AppImages.imgLevelComplate,
                          height: isTablet ? 150 : 90,
                        ),
                        kGap50,
                        Image.asset(
                          AppImages.imgBintang5,
                          // ? AppImages.imgBintang5
                          // : AppImages.imgBintang3,
                          height: isTablet ? 130 : 120,
                        ),
                        kGap50,
                        Text(
                          'SCORE',
                          style: AppStyles.montserrat64Bold.copyWith(
                            fontSize: sizeFontText,
                            color: AppColors.orange,
                          ),
                        ),
                        kGap25,

                        // Tampilkan skor dinamis
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.orange,
                          ),
                          child: Text(
                            '100',
                            style: AppStyles.montserrat64Bold.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),

                        Spacer(),

                        Row(
                          spacing: 30,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomButton(
                                text: 'BACK',
                                backgroundColor: AppColors.orange,
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    SlidePageRoute(page: SiswaHomeView()),
                                    (route) => false,
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: CustomButton(
                                text: 'NEXT',
                                backgroundColor: AppColors.orange,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    SlidePageRoute(page: LeaderboardView()),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
