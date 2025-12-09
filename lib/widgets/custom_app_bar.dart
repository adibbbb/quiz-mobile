// import 'package:flutter_svg/svg.dart';

// import '../commons.dart';
// import '../pages/home/widgets/label_card.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final bool isCenterTitle;
//   final EdgeInsets? padding;
//   final bool isShared;
//   final VoidCallback? onBackTap;

//   const CustomAppBar({
//     super.key,
//     required this.title,
//     this.isCenterTitle = true,
//     this.padding,
//     this.isShared = false,
//     this.onBackTap,
//   });

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: AppColors.brokenWhite,
//       centerTitle: isCenterTitle,
//       title: eventLabel(title: title, padding: padding),
//       leadingWidth: 60,
//       leading: GestureDetector(
//         onTap: onBackTap ?? () => Navigator.pop(context),
//         child: Container(
//           margin: kPadd14,
//           padding: kPadd6,
//           decoration: BoxDecoration(
//             borderRadius: kRadius6,
//             border: Border.all(color: AppColors.black),
//             color: AppColors.lavender,
//             boxShadow: const [BoxShadow(offset: Offset(3, 3))],
//           ),
//           child: SvgPicture.asset(AppIcons.icBack),
//         ),
//       ),
//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(1.0),
//         child: Container(
//           // ignore: deprecated_member_use
//           color: const Color(0xff333333).withOpacity(0.5),
//           height: 1.0,
//         ),
//       ),

//       // TOMBOL ACTIONS
//       actions: [
//         isShared
//             ? GestureDetector(
//               onTap: () {
//                 print('tekan share');
//               },
//               child: Container(
//                 margin: kPadd14,
//                 padding: kPadd6,
//                 decoration: BoxDecoration(
//                   borderRadius: kRadius6,
//                   border: Border.all(color: AppColors.black),
//                   color: AppColors.lavender,
//                   boxShadow: const [BoxShadow(offset: Offset(3, 3))],
//                 ),
//                 child: SvgPicture.asset(AppIcons.icShare),
//               ),
//             )
//             : SizedBox.shrink(),
//       ],
//     );
//   }
// }
