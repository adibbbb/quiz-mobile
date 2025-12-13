import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../app/custom_transition.dart';
import '../commons.dart';
import '../pages/guru/pages/leaderboard_view.dart';
import '../pages/guru/widget/data_guru.dart';
import '../pages/login_page/default_login_view.dart';
import '../provider/authentication_provider.dart';
import 'custom_button.dart';

typedef LevelMiddleBuilder = Widget Function(Map<String, dynamic> level);

class CustomLevelCarousel extends StatefulWidget {
  final List<Map<String, dynamic>> levelData;
  final CarouselSliderController carouselController;
  final int initialIndex; // index awal
  final ValueChanged<int>? onPageChanged;
  final bool isShowButton;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final LevelMiddleBuilder? middleBuilder;

  /// Callback saat level di-click
  final void Function(Map<String, dynamic> level, int index)? onLevelTap;

  const CustomLevelCarousel({
    super.key,
    required this.levelData,
    required this.carouselController,
    this.initialIndex = 0,
    this.onPageChanged,
    this.isShowButton = true,
    this.buttonText = 'LeaderBoard',
    this.onButtonPressed,
    this.middleBuilder,
    this.onLevelTap,
  });

  @override
  State<CustomLevelCarousel> createState() => _CustomLevelCarouselState();
}

class _CustomLevelCarouselState extends State<CustomLevelCarousel> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // ambil dari parent
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // BACKGROUND ANIMATED CONTAINER
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeIn,
          decoration: BoxDecoration(image: backgroundLevel(_currentIndex)),
        ),

        LayoutBuilder(
          builder: (context, constraints) {
            final bool isTablet = constraints.maxWidth >= 600;

            final double sizeLabelText = isTablet ? 72 : 30;
            final double sizeTitleText = isTablet ? 32 : 20;
            final double sizeminTitleText = isTablet ? 20 : 10;
            final double sizeDescText = isTablet ? 18 : 10;

            return Center(
              child: CarouselSlider.builder(
                carouselController: widget.carouselController,
                itemCount: widget.levelData.length,
                itemBuilder: (context, index, _) {
                  final level = widget.levelData[index];

                  // WRAP CARD DENGAN GESTURE DETECTOR
                  return GestureDetector(
                    onTap: () {
                      if (widget.onLevelTap != null) {
                        widget.onLevelTap!(level, index);
                      }
                    },
                    child: Column(
                      children: [
                        Expanded(
                          flex: 10,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.fromLTRB(24, 32, 24, 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(67),
                              gradient: backgroundGradient(index),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withValues(alpha: 0.1),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                  offset: Offset(0, -4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Level ${index + 1}',
                                  style: AppStyles.lilitaOne72.copyWith(
                                    color: level['color'],
                                    fontSize: sizeLabelText,
                                  ),
                                ),

                                // MIDDLE WIDGET REUSABLE
                                Expanded(
                                  child:
                                      widget.middleBuilder != null
                                          ? widget.middleBuilder!(level)
                                          : SvgPicture.asset(
                                            AppIcons.icPlus,
                                            height: 100,
                                            // ignore: deprecated_member_use
                                            color: level['color'],
                                          ),
                                ),

                                Column(
                                  children: [
                                    AutoSizeText(
                                      level['title'],
                                      minFontSize: sizeminTitleText,
                                      maxLines: 1,
                                      style: AppStyles.montserrat32Bold
                                          .copyWith(
                                            fontSize: sizeTitleText,
                                            color: level['color'],
                                          ),
                                    ),
                                    kGap10,
                                    AutoSizeText(
                                      level['desc'],
                                      textAlign: TextAlign.center,
                                      style: AppStyles.montserrat18Bold
                                          .copyWith(
                                            fontSize: sizeDescText,
                                            color: level['color'],
                                            shadows: [
                                              Shadow(
                                                color: AppColors.black
                                                    .withValues(alpha: 0.05),
                                                offset: Offset(0, 4),
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // CONDITIONAL BUTTON
                        if (widget.isShowButton && index == 0) ...[
                          kGap20,
                          Expanded(
                            child: CustomButton(
                              backgroundColor: AppColors.green,
                              borderRadius: kRadius20,
                              text: widget.buttonText,
                              onPressed:
                                  widget.onButtonPressed ??
                                  () {
                                    Navigator.push(
                                      context,
                                      SlidePageRoute(page: LeaderboardView()),
                                    );
                                  },
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  initialPage: widget.initialIndex,
                  height: 620,
                  viewportFraction: 0.6,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index; // update background otomatis
                    });
                    if (widget.onPageChanged != null) {
                      widget.onPageChanged!(index);
                    }
                  },
                ),
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            padding: EdgeInsets.only(top: 48, left: 16),

            color: AppColors.white,
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 26,
              shadows: [
                // BoxShadow(color: AppColors.black.withAlpha(100), blurRadius: 5),
              ],
            ),

            onPressed: () {
              context.read<AuthenticationProvider>().logout();
              Navigator.pushAndRemoveUntil(
                context,
                ScalePageRoute(page: DefaultLoginView()),
                (route) => route.isFirst,
              );
            },
          ),
        ),
      ],
    );
  }
}
