import 'package:provider/provider.dart';
import 'package:quiz/app/extensions.dart';
import '../../../commons.dart';
import '../../../provider/soal_guru_provider.dart';
import '../../../provider/auth_provider.dart';
import '../../../widgets/custom_button.dart';
import '../widget/form_nambah_soal.dart';

class GuruLevelView extends StatelessWidget {
  final int level;
  final String bgImage;
  final Color titleColor;

  const GuruLevelView({
    super.key,
    required this.level,
    required this.bgImage,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final teacherProvider = Provider.of<TeacherQuestionProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final guruId = authProvider.loggedGuru?['id'] ?? '';

    if (teacherProvider.getQuestions(level).isEmpty) {
      teacherProvider.fetchQuestions(level, guruId);
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover),
        ),
        child: GestureDetector(
          onTap: () {
            context.unfocusKeyboard();
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(67),
                  gradient: LinearGradient(
                    colors: [AppColors.white, Color(0xFFE8F6FF), AppColors.blue],
                    stops: [0.0, 0.5, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'LEVEL $level',
                      style: AppStyles.lilitaOne42.copyWith(color: titleColor),
                    ),
                    const Divider(),
                    kGap20,
          
                    // Form soal
                    Expanded(child: TeacherQuestionForm(level: level)),
          
                    kGap20,
          
                    // Tombol Add (+)
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap:
                          () => teacherProvider.addQuestion(
                            level,
                          ), // add soal sesuai level
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: const Color(0xff000000).withOpacity(0.1),
                              offset: const Offset(2, 8),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          AppIcons.icPlus,
                          height: 30,
                          color: AppColors.blue,
                        ),
                      ),
                    ),
          
                    const SizedBox(height: 20),
          
                    // Tombol Cancel & Done
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onPressed: () => Navigator.pop(context),
                            text: 'Cancel',
                            borderRadius: kRadius20,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: CustomButton(
                            text: 'Done',
                            borderRadius: kRadius20,
                            backgroundColor: AppColors.green,
                            onPressed:
                                () => teacherProvider.saveQuestions(
                                  level: level,
                                  context: context,
                                  authProvider: authProvider,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
