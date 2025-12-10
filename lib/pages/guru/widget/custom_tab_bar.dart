import '../../../commons.dart';

class CustomTabBar extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> children;
  final double borderRadius;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.children,
    this.borderRadius = 42,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// TAB BAR
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff000000).withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: List.generate(widget.tabs.length, (index) {
              return Expanded(
                child: _tabItem(text: widget.tabs[index], index: index),
              );
            }),
          ),
        ),

        const SizedBox(height: 16),

        /// TAB CONTENT
        AnimatedSwitcher(
          duration: const Duration(
            milliseconds: 300,
          ), // lebih lama = lebih smooth
          transitionBuilder: (Widget child, Animation<double> animation) {
            final inAnimation = Tween<Offset>(
              begin: const Offset(1.0, 0.0), // slide dari kanan
              end: Offset.zero,
            ).animate(animation);

            final fadeAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation);

            return SlideTransition(
              position: inAnimation,
              child: FadeTransition(opacity: fadeAnimation, child: child),
            );
          },
          child: KeyedSubtree(
            key: ValueKey(selectedIndex),
            child: widget.children[selectedIndex],
          ),
        ),
      ],
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
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: isSelected ? AppColors.blueDongker : AppColors.white,
        ),
        child: Center(
          child: Text(
            text,
            style: AppStyles.poppins12ExtraBold.copyWith(
              color: isSelected ? AppColors.white : AppColors.blueDongker,
            ),
          ),
        ),
      ),
    );
  }
}
