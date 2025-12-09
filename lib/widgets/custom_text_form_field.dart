// import 'package:flutter/services.dart';
// import '../commons.dart';

// import 'spacer.dart';

// class CustomTextFormField extends StatelessWidget {
//   final AutovalidateMode? validateMode;
//   final String? hintText;
//   final String? title;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final TextEditingController? controller;
//   final bool obscureText;
//   final String? Function(String? value)? validator;
//   final String? errorText;
//   final String? helperText;
//   final TextInputType keyboardType;
//   final ValueChanged<String>? onChanged;
//   final void Function(String? value)? onSaved;
//   final int maxLines;
//   final int? maxLength;
//   final double height;
//   final bool readOnly;
//   final Function()? onTap;
//   final Function()? onEditingComplete;
//   final double spacer;
//   final TextCapitalization textCapitalization;
//   final TextStyle titleStyle;
//   final Color? backgroundColor;
//   final TextInputAction? inputAction;
//   final FocusNode? focusNode;
//   final List<TextInputFormatter>? inputFormatters;

//   const CustomTextFormField({
//     super.key,
//     this.hintText,
//     this.title,
//     this.controller,
//     this.maxLength,
//     this.obscureText = false,
//     this.validator,
//     this.readOnly = false,
//     this.errorText,
//     this.helperText,
//     this.keyboardType = TextInputType.text,
//     this.onChanged,
//     this.maxLines = 1,
//     this.height = 40,
//     this.onTap,
//     this.spacer = 8,
//     this.suffixIcon,
//     this.textCapitalization = TextCapitalization.none,
//     this.titleStyle = AppStyles.comfortaa12Regular,
//     this.backgroundColor,
//     this.prefixIcon,
//     this.validateMode,
//     this.inputFormatters,
//     this.onSaved,
//     this.onEditingComplete,
//     this.focusNode,
//     this.inputAction,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (title != null) ...[
//           Text(title ?? "", style: titleStyle),
//           SpacerHeight(spacer),
//         ],
//         Container(
//           height: height,
//           decoration: _decoration,
//           child: TextFormField(
//             focusNode: focusNode,
//             inputFormatters: inputFormatters,
//             autovalidateMode: validateMode,
//             maxLength: maxLength,
//             textCapitalization: textCapitalization,
//             cursorColor: AppColors.black,
//             controller: controller,
//             obscureText: obscureText,
//             validator: validator,
//             onSaved: onSaved,
//             onEditingComplete: onEditingComplete,
//             textInputAction: inputAction,
//             keyboardType: keyboardType,
//             onChanged: onChanged,
//             readOnly: readOnly,
//             maxLines: maxLines,
//             onTap: onTap,
//             decoration: InputDecoration(
//               prefixIcon: prefixIcon,
//               fillColor: backgroundColor,
//               filled: backgroundColor != null,
//               hintText: hintText,
//               errorText: errorText,
//               helperText: helperText,
//               border: _borderStyle,
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 16,
//                 vertical: 8,
//               ),
//               suffixIcon: suffixIcon,
//               focusedBorder: _borderStyle,
//               enabledBorder: _borderStyle,
//               errorBorder: _borderStyle,
//               focusedErrorBorder: _borderStyle,
//               counterText: "", 
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class CustomTextFormFieldPassword extends StatefulWidget {
//   final AutovalidateMode? validateMode;
//   final String? hintText;
//   final TextEditingController? controller;
//   final bool intialHideStatus;
//   final String? Function(String?)? validator;
//   final ValueChanged<String>? onChanged;
//   final void Function(String? value)? onSaved;
//   final String? errorText;
//   final double height;
//   const CustomTextFormFieldPassword({
//     super.key,
//     this.hintText,
//     this.controller,
//     this.intialHideStatus = true,
//     this.validator,
//     this.errorText,
//     this.onChanged,
//     this.height = 40,
//     this.validateMode,
//     this.onSaved,
//   });

//   @override
//   State<CustomTextFormFieldPassword> createState() =>
//       _CustomTextFormFieldPasswordState();
// }

// class _CustomTextFormFieldPasswordState
//     extends State<CustomTextFormFieldPassword> {
//   late ValueNotifier<bool> isShowingTxt;
//   @override
//   void initState() {
//     isShowingTxt = ValueNotifier(widget.intialHideStatus);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           child: ValueListenableBuilder(
//             valueListenable: isShowingTxt,
//             builder: (context, value, _) {
//               return Container(
//                 decoration: _decoration,
//                 child: TextFormField(
//                   onSaved: widget.onSaved,
//                   autovalidateMode: widget.validateMode,
//                   cursorColor: AppColors.black,
//                   controller: widget.controller,
//                   obscureText: value,
//                   obscuringCharacter: '●',
//                   validator: widget.validator,
//                   keyboardType: TextInputType.visiblePassword,
//                   onChanged: widget.onChanged,
//                   decoration: InputDecoration(
//                     hintText: widget.hintText,
//                     errorText: widget.errorText,
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 8,
//                     ),
//                     suffixIcon: IconButton(
//                       onPressed: () {
//                         isShowingTxt.value = !isShowingTxt.value;
//                       },
//                       icon: Icon(
//                         value == true
//                             ? Icons.visibility_outlined
//                             : Icons.visibility_off_outlined,
//                         color: const Color(0xff626262),
//                       ),
//                     ),
//                     border: _borderStyle,
//                     focusedBorder: _borderStyle,
//                     enabledBorder: _borderStyle,
//                     errorBorder: _borderStyle,
//                     focusedErrorBorder: _borderStyle,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// OutlineInputBorder get _borderStyle => OutlineInputBorder(
//   borderRadius: kRadius8,
//   borderSide: const BorderSide(color: AppColors.black),
// );

// get _decoration => BoxDecoration(
//   color: AppColors.white,
//   boxShadow: const [BoxShadow(color: AppColors.black, offset: smallShadow)],
//   borderRadius: kRadius8,
// );
