import 'package:flutter/material.dart';

import '../../../resources/colors_app.dart';

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

    Color textColor = Colors.black;

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
      labelColor = isSelected ? selectedColor : Colors.black;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
            CircleAvatar(
              backgroundColor:
                  showCorrectAnswer
                      ? backgroundColor
                      : isSelected
                      ? backgroundColor
                      : selectedColor,
              child: Text(
                label,
                style: TextStyle(
                  color: labelColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: textColor, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
