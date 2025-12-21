import 'package:provider/provider.dart';
import 'package:quiz/app/finite_state.dart';
import 'package:quiz/app/navigator_keys.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/provider/teacher_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../app/extensions.dart';
import '../../../commons.dart';
import '../../../widgets/custom_button.dart';
import '../widget/teacher_question_form.dart';

class GuruLevelView extends StatefulWidget {
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
  State<GuruLevelView> createState() => _GuruLevelViewState();
}

class _GuruLevelViewState extends State<GuruLevelView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var prov = context.read<TeacherProvider>();
      switch (widget.level) {
        case 1:
          prov.fetchQuestions("quiz_1");
          break;
        case 2:
          prov.fetchQuestions("quiz_2");
          break;
        case 3:
          prov.fetchQuestions("quiz_3");
          break;
        default:
      }
    });
  }

  ScrollController scrlController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.bgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            context.unfocusKeyboard();
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(67),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.white,
                      Color(0xFFE8F6FF),
                      AppColors.blue,
                    ],
                    stops: [0.0, 0.5, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Consumer<TeacherProvider>(
                  builder: (context, prov, _) {
                    return Column(
                      children: [
                        Text(
                          'LEVEL ${widget.level}',
                          style: AppStyles.lilitaOne42.copyWith(
                            color: widget.titleColor,
                          ),
                        ),
                        const Divider(),
                        kGap20,

                        // Form soal
                        Expanded(
                          child: TeacherQuestionForm(
                            level: widget.level,
                            provider: prov,
                            scrollControl: scrlController,
                          ),
                        ),

                        kGap20,

                        // Tombol Add (+)
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap:
                              prov.state.isFirstTry
                                  ? null
                                  : () {
                                    final uuid = const Uuid();
                                    prov.addQuestion(
                                      Question(
                                        id: uuid.v4(),
                                        question: "Soal..",
                                        options: [
                                          "opsi 1",
                                          "opsi 2",
                                          "opsi 3",
                                          "opsi 4",
                                        ],
                                        correctAnswer: 0,
                                      ),
                                    );

                                    // scroll ui ke paling bawah
                                    scrlController.animateTo(
                                      scrlController.position.maxScrollExtent +
                                          400,
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeOut,
                                    );
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
                                  color: const Color(
                                    0xff000000,
                                  ).withOpacity(0.1),
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

                        kGap20,

                        // Tombol Cancel & Done
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                onPressed: () {
                                  prov.cancelEdit();
                                  Navigator.pop(context);
                                },
                                text: 'Cancel',
                                borderRadius: kRadius20,
                              ),
                            ),
                            kGap20,
                            Expanded(
                              child: CustomButton(
                                text: 'Done',
                                borderRadius: kRadius20,
                                backgroundColor: AppColors.green,
                                onPressed:
                                    prov.state.isLoading
                                        ? null
                                        : () async {
                                          bool isSuccessSave = false;
                                          switch (widget.level) {
                                            case 1:
                                              isSuccessSave = await prov
                                                  .saveAll(quizId: "quiz_1");
                                              break;
                                            case 2:
                                              isSuccessSave = await prov
                                                  .saveAll(quizId: "quiz_2");
                                              break;
                                            case 3:
                                              isSuccessSave = await prov
                                                  .saveAll(quizId: "quiz_3");
                                              break;
                                            default:
                                          }

                                          if (isSuccessSave) {
                                            Navigator.pop(
                                              navigatorKey.currentContext ??
                                                  context,
                                            );
                                          }
                                        },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
