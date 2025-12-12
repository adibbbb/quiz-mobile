import 'package:provider/provider.dart';

import '../../../app/custom_transition.dart';
import '../../../commons.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../provider/auth_provider.dart';
import '../../../widgets/custom_level_carousel.dart';
import '../widget/data_guru.dart';
import 'guru_level1_view.dart';
import 'guru_level2_view.dart';
import 'guru_level3_view.dart';

class GuruHomeView extends StatefulWidget {
  const GuruHomeView({super.key});

  @override
  State<GuruHomeView> createState() => _GuruHomeViewState();
}

class _GuruHomeViewState extends State<GuruHomeView> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomLevelCarousel(
            levelData: levelData,
            carouselController: _carouselController,
            onLevelTap: (level, index) {
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    SlidePageRoute(page: GuruLevel1View()),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    SlidePageRoute(page: GuruLevel2View()),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    SlidePageRoute(page: GuruLevel3View()),
                  );
                  break;
              }
            },
          ),
          Positioned(
            top: 50,
            left: 16,
            child: GestureDetector(
              onTap: () {
                context.read<AuthProvider>().logoutGuru();
              },
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
