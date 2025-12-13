import '../../app/custom_transition.dart';
import '../../commons.dart';
import 'login_view.dart';

class DefaultLoginView extends StatefulWidget {
  const DefaultLoginView({super.key});

  @override
  State<DefaultLoginView> createState() => _DefaultLoginViewState();
}

class _DefaultLoginViewState extends State<DefaultLoginView> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.imgBgHome),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(25),
                Text(
                  'PLAY',
                  style: AppStyles.montserrat32Bold.copyWith(
                    color: AppColors.white,
                  ),
                ),

                kGap25,

                Image.asset(height: 100, AppImages.imgQuizGo),

                kGap45,

                _tabBar(),

                kGap93,
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      SlidePageRoute(
                        page: LoginView(
                          type:
                              selectedIndex == 0
                                  ? LoginViewType.siswa
                                  : LoginViewType.guru,
                        ),
                      ),
                    );
                  },
                  child: SvgPicture.asset(AppIcons.icPlayButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _tabBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(42),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: _tabItem(text: "SISWA", index: 0)),
          Expanded(child: _tabItem(text: "GURU", index: 1)),
        ],
      ),
    );
  }

  Widget _tabItem({required String text, required int index}) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(42),
          color: isSelected ? AppColors.blue : AppColors.white,
        ),
        child: Center(
          child: Text(
            text,
            style: AppStyles.poppins12ExtraBold.copyWith(
              color: isSelected ? AppColors.white : AppColors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
