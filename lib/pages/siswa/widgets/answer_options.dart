import 'package:quiz/commons.dart';

class AnswerOption extends StatelessWidget {
  final String label;
  final String text;
  final bool isSelected;
  final bool showCorrectAnswer;
  final bool isCorrect;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color backgroundColor;

  const AnswerOption({
    super.key,
    required this.label,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.showCorrectAnswer = false,
    this.isCorrect = false,
    required this.selectedColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = backgroundColor;

    Color textColor = isSelected ? Colors.white : Colors.black;

    if (showCorrectAnswer) {
      if (isCorrect) {
        bg = AppColors.green;
        textColor = Colors.white;
      } else if (isSelected && !isCorrect) {
        bg = AppColors.red;
        textColor = Colors.white;
      }
    } else if (isSelected) {
      bg = selectedColor;
    }

    Color labelColor;
    if (showCorrectAnswer) {
      if (isCorrect) {
        labelColor = AppColors.green; // jawaban benar
      } else if (isSelected && !isCorrect) {
        labelColor = AppColors.red; // jawaban salah
      } else {
        labelColor = Colors.black; // lainnya
      }
    } else {
      labelColor = isSelected ? selectedColor : Colors.white;
    }

    return GestureDetector(
      onTap: showCorrectAnswer ? null : onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isTablet = constraints.maxWidth >= 600;
          final double sizeAnswerText = isTablet ? 22 : 16;
          final EdgeInsetsGeometry padding =
              isTablet
                  ? EdgeInsets.fromLTRB(25, 15, 15, 15) // ubah lagi sesuai tab
                  : EdgeInsets.fromLTRB(12, 12, 8, 12);

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: padding,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 2),
                  color: Colors.black12,
                ),
              ],
            ),
            child: Row(
              children: [
                // 🅰️ LABEL
                CircleAvatar(
                  backgroundColor:
                      showCorrectAnswer
                          ? backgroundColor
                          : isSelected
                          ? backgroundColor
                          : selectedColor,
                  child: Text(
                    label,
                    style: AppStyles.poppins24Medium.copyWith(
                      color: labelColor,
                      fontSize: 18,
                    ),
                  ),
                ),

                kGap12,

                // 📄 TEXT JAWABAN
                Expanded(
                  flex: 3,
                  child: Text(
                    text,
                    style: AppStyles.poppins24Medium.copyWith(
                      color: textColor,
                      fontSize: sizeAnswerText,
                    ),
                  ),
                ),

                Spacer(),
                // 🔘 RADIO BUTTON
                Radio<bool>(
                  value: true,
                  groupValue: isSelected,
                  onChanged: showCorrectAnswer ? null : (_) => onTap(),
                  activeColor: Colors.white,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
