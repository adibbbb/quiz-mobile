import 'package:auto_size_text/auto_size_text.dart';

import '../commons.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        final bool isTablet = maxWidth >= 600;

        final double fontSizeLabel = isTablet ? 24 : 14;
        final double fontSizeText = isTablet ? 24 : 14;

        final double horizontalPadding = isTablet ? 40 : 16;
        final double verticalPadding = isTablet ? 20 : 10;
        final double radius = isTablet ? 42 : 16;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                label,
                maxLines: 1,
                minFontSize: 8,
                style: AppStyles.poppins24Medium.copyWith(
                  fontSize: fontSizeLabel,
                  color: AppColors.greenLumut,
                ),
              ),
              kGap8,
              Expanded(
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: AppStyles.poppins24Medium.copyWith(
                      fontSize: fontSizeLabel,
                      color: Color(0xffBBBBBB),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  style: AppStyles.poppins24Medium.copyWith(
                    fontSize: fontSizeText,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


class CustomPasswordTextFormField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;

  const CustomPasswordTextFormField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
  });

  @override
  State<CustomPasswordTextFormField> createState() =>
      _CustomPasswordTextFormFieldState();
}

class _CustomPasswordTextFormFieldState
    extends State<CustomPasswordTextFormField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isTablet = constraints.maxWidth >= 600;

        final double fontSizeLabel = isTablet ? 24 : 14;
        final double fontSizeText = isTablet ? 24 : 14;

        final double horizontalPadding = isTablet ? 40 : 16;
        final double verticalPadding = isTablet ? 20 : 10;
        final double radius = isTablet ? 42 : 16;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Row(
            children: [
              Text(
                widget.label,
                style: AppStyles.poppins24Medium.copyWith(
                  fontSize: fontSizeLabel,
                  color: AppColors.greenLumut,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onDoubleTap: _toggleVisibility,
                  child: TextFormField(
                    controller: widget.controller,
                    obscureText: _obscureText,
                    enableInteractiveSelection: false,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: const TextStyle(
                        color: Color(0xFFBDBDBD),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: AppStyles.poppins24Medium.copyWith(
                      fontSize: fontSizeText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
