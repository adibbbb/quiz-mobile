// import 'package:flutter_svg/flutter_svg.dart';

// import '../commons.dart';

// class CustomButton extends StatelessWidget {
//   final double width;
//   final double height;
//   final void Function()? onPressed;
//   final String text;
//   final Color backgroundColor;
//   final TextStyle? textStyle;
//   final EdgeInsets margin;

//   const CustomButton({
//     super.key,
//     this.width = double.infinity,
//     this.height = 40,
//     required this.onPressed,
//     required this.text,
//     this.backgroundColor = AppColors.lavender,
//     this.textStyle,
//     this.margin = EdgeInsets.zero,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: width,
//       margin: margin,
//       decoration: BoxDecoration(
//         borderRadius: kRadius8,
//         color: backgroundColor,
//         border: Border.all(color: AppColors.black),
//         boxShadow: const [BoxShadow(offset: mediumShadow)],
//       ),
//       child: TextButton(
//         onPressed: onPressed,
//         child: Text(
//           text,
//           style:
//               textStyle ??
//               AppStyles.comfortaa14Medium.copyWith(color: AppColors.white),
//         ),
//       ),
//     );
//   }
// }

