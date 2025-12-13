import 'package:carousel_slider/carousel_slider.dart';

import '../../../app/custom_transition.dart';
import '../../../commons.dart';
import '../../../widgets/custom_level_carousel.dart';
import '../../guru/widget/data_guru.dart';
import 'siswa_level_view.dart';

class SiswaHomeView extends StatefulWidget {
  const SiswaHomeView({super.key});

  @override
  State<SiswaHomeView> createState() => _SiswaHomeViewState();
}

class _SiswaHomeViewState extends State<SiswaHomeView> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomLevelCarousel(
        levelData: levelData,
        carouselController: _carouselController,
        initialIndex: 0,
        isShowButton: false,
        middleBuilder: (level) => Image.asset(level['image']),
        onLevelTap: (level, index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                SlidePageRoute(
                  page: SiswaLevelView(
                    levelSiswa: index + 1,
                    bgImage: AppImages.imgBgLevel1,
                    imgBgLevel: AppImages.imgbgsoalLevel1,
                  ),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                SlidePageRoute(
                  page: SiswaLevelView(
                    levelSiswa: index + 1,
                    bgImage: AppImages.imgBgLevel2,
                    imgBgLevel: AppImages.imgbgsoalLevel2,
                  ),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                SlidePageRoute(
                  page: SiswaLevelView(
                    levelSiswa: index + 1,
                    bgImage: AppImages.imgBgLevel3,
                    imgBgLevel: AppImages.imgbgsoalLevel3,
                  ),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
