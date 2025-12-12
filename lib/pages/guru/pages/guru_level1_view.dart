import 'package:provider/provider.dart';
import '../../../commons.dart';
import '../../../provider/pertanyaan_guru_provider.dart';
import '../../../widgets/custom_button.dart';
import '../widget/custom_form_jawaban.dart';

class GuruLevel1View extends StatelessWidget {
  const GuruLevel1View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    'LEVEL 1',
                    style: AppStyles.lilitaOne42.copyWith(
                      color: AppColors.blue,
                    ),
                  ),
                  const Divider(),
                  kGap20,

                  // Form soal
                  Expanded(child: TeacherQuestionForm()),

                  kGap20,

                  // Tombol Add (+)
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Provider.of<TeacherQuestionProvider>(
                        context,
                        listen: false,
                      ).addQuestion();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            // ignore: deprecated_member_use
                            color: const Color(0xff000000).withOpacity(0.1),
                            offset: const Offset(2, 8),
                          ),
                        ],
                      ),
                      child: SvgPicture.asset(
                        AppIcons.icPlus,
                        height: 30,
                        // ignore: deprecated_member_use
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
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: 'Cancel',
                          borderRadius: kRadius20,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomButton(
                          onPressed: () {},
                          text: 'Done',
                          borderRadius: kRadius20,
                          backgroundColor: AppColors.green,
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
    );
  }
}
