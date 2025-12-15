import 'package:quiz/app/custom_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../commons.dart';
import '../login_page/default_login_view.dart';
import 'data_onboarding.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int currentIndex = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F3),
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          itemCount: onboardingData.length,
          onPageChanged: (value) {
            setState(() => currentIndex = value);
          },
          itemBuilder: (context, index) {
            final item = onboardingData[index];
            final bool isMiddle = index == 1;

            return Stack(
              children: [
                /// PANEL WARNA
                Align(
                  alignment:
                      isMiddle ? Alignment.bottomCenter : Alignment.topCenter,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    width: MediaQuery.of(context).size.width * 0.7,
                    height:
                        isMiddle
                            ? MediaQuery.of(context).size.height * 0.62
                            : MediaQuery.of(context).size.height * 0.85,
                    decoration: BoxDecoration(
                      color: item.backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft:
                            isMiddle ? const Radius.circular(250) : Radius.zero,
                        topRight:
                            isMiddle ? const Radius.circular(250) : Radius.zero,
                        bottomLeft:
                            isMiddle ? Radius.zero : const Radius.circular(250),
                        bottomRight:
                            isMiddle ? Radius.zero : const Radius.circular(250),
                      ),
                    ),
                  ),
                ),

                /// CONTENT
                LayoutBuilder(
                  builder: (context, constraints) {
                    final bool isTablet = constraints.maxWidth >= 600;
                    final double sizeImageAsset = isTablet ? 0.7 : 0.45;
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            item.title,
                            style: AppStyles.lilitaOne48.copyWith(
                              color: item.textColor,
                              fontSize: 45,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          Image.asset(
                            item.image,
                            height: MediaQuery.of(context).size.height * sizeImageAsset,
                          ),
                        ],
                      ),
                    );
                  },
                ),

                /// DOT INDICATOR
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        /// DOTS (CENTER)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            onboardingData.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(right: 6),
                              width: currentIndex == index ? 18 : 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color:
                                    currentIndex == 1
                                        ? Colors.white
                                        : item.backgroundColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),

                        /// NEXT BUTTON (RIGHT)
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            color: item.backgroundColor,
                            icon: const Icon(Icons.arrow_forward_ios),
                            onPressed: () async {
                              if (currentIndex < onboardingData.length - 1) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setBool(
                                  'has_seen_onboarding',
                                  true,
                                );
                                Navigator.push(
                                  context,
                                  SlidePageRoute(page: DefaultLoginView()),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
