import 'package:provider/provider.dart';
import '../../../app/custom_transition.dart';
import '../../../commons.dart';
import '../../../provider/jawaban_siswa_provider.dart';
import '../../../provider/soal_guru_provider.dart';
import '../../../widgets/custom_button.dart';
import 'siswa_level_complate_view.dart';
import 'siswa_preview_jawaban_view.dart';

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
  late Color backgroundContainerColor;
  late Color circleAvatarColor;
  late Color buttonNextColor;

  @override
  void initState() {
    super.initState();
    _setColorsByLevel();
    // Optional: fetch soal dari provider di sini
    final teacherProvider = Provider.of<TeacherQuestionProvider>(
      context,
      listen: false,
    );
    teacherProvider.fetchQuestions(
      widget.levelSiswa,
      '12345',
    ); // ganti dengan guruId yang sesuai
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
    final teacherProvider = Provider.of<TeacherQuestionProvider>(context);
    final studentProvider = Provider.of<StudentAnswerProvider>(context);

    // Ambil soal dari provider
    final questions = teacherProvider.getQuestions(widget.levelSiswa);

    // Jika soal belum ada, tampilkan loading
    if (questions.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Ambil index soal saat ini
    final index = studentProvider.currentQuestionIndex;

    // Kalau semua soal selesai, langsung ke level complete
    if (index >= questions.length) {
      // Semua soal selesai → langsung LevelComplete
      Future.microtask(() {
        Navigator.of(context).pushAndRemoveUntil(
          SlidePageRoute(
            page: SiswaLevelComplateView(levelsiswa: widget.levelSiswa),
          ),
          (route) => false, // hapus semua route sebelumnya
        );
      });
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentQuestion = questions[index];

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
                          currentQuestion.question,
                          style: AppStyles.poppins24Medium,
                        ),
                        kGap20,
                        ...List.generate(currentQuestion.answers.length, (i) {
                          final label = ['A', 'B', 'C', 'D'][i];
                          return _buildAnswerOption(
                            label: label,
                            text: currentQuestion.answers[i],
                            isSelected:
                                studentProvider.getAnswer(
                                  level: widget.levelSiswa,
                                  questionIndex: index,
                                ) ==
                                label,
                            onTap:
                                () => studentProvider.setAnswer(
                                  level: widget.levelSiswa,
                                  questionIndex: index,
                                  answer: label,
                                ),
                          );
                        }),
                        kGap23,
                        CustomButton(
                          text: 'Next',
                          backgroundColor: buttonNextColor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => SiswaPreviewAnswerView(
                                      levelSiswa: widget.levelSiswa,
                                      questionIndex: index,
                                      bgImage: widget.bgImage,
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
                    widget.imgBgLevel.toString(),
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

  Widget _buildAnswerOption({
    required String label,
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? circleAvatarColor : backgroundContainerColor,
          borderRadius: kRadius42,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              offset: Offset(0, 4),
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isSelected ? Colors.white : circleAvatarColor,
              child: Text(
                label,
                style: AppStyles.poppins24Medium.copyWith(
                  color: isSelected ? circleAvatarColor : Colors.white,
                ),
              ),
            ),
            kGap16,
            Expanded(
              child: Text(
                text,
                style: AppStyles.poppins24Medium.copyWith(
                  color: isSelected ? Colors.white : AppColors.black,
                ),
              ),
            ),
          ],
        ),
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
