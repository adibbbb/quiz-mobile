import '../commons.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double? height;
  final void Function()? onPressed;
  final String text;
  final Color backgroundColor;
  final TextStyle? textStyle;
  final EdgeInsets margin;
  final BorderRadiusGeometry borderRadius;

  const CustomButton({
    super.key,
    this.width = double.infinity,
    this.height = 70,
    required this.onPressed,
    required this.text,
    this.backgroundColor = AppColors.orangeMuda,
    this.textStyle,
    this.margin = EdgeInsets.zero,
    this.borderRadius = const BorderRadius.all(Radius.circular(42)),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: backgroundColor,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style:
              textStyle ??
              AppStyles.lilitaOne24.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
