import 'dart:ui';

import 'package:quiz/models/quiz_attempt.dart';

import '../../../app/custom_transition.dart';
import '../../../commons.dart';
import '../../../widgets/custom_button.dart';
import '../../guru/pages/leaderboard_view.dart';
import 'siswa_home_view.dart';

class SiswaLevelComplateView extends StatefulWidget {
  final QuizAttempt result;
  const SiswaLevelComplateView(this.result, {super.key});

  @override
  State<SiswaLevelComplateView> createState() => _SiswaLevelComplateViewState();
}

class _SiswaLevelComplateViewState extends State<SiswaLevelComplateView> {
  double _bintangOpacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Trigger fade-in saat halaman muncul
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _bintangOpacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
              height: screenHeight * 0.75,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(73),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final bool isTablet = constraints.maxWidth >= 600;
                  final double sizeFontText = isTablet ? 80 : 40;
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
                          height: isTablet ? 150 : 140,
                        ),
                        kGap60,
                        AnimatedOpacity(
                          opacity: _bintangOpacity,
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeInOut,
                          child: Image.asset(
                            (widget.result.score ?? 0) < 70
                                ? AppImages.imgBintang3
                                : AppImages.imgBintang5,
                            height: isTablet ? 130 : 120,
                          ),
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
                            '${widget.result.score}',
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
                                  context.fadeRemoveUntil(SiswaHomeView());
                                },
                              ),
                            ),
                            Expanded(
                              child: CustomButton(
                                text: 'NEXT',
                                backgroundColor: AppColors.orange,
                                onPressed: () {
                                  context.fadeTo(
                                    LeaderboardView(
                                      level: widget.result.level ?? 1,
                                    ),
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
