import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:quiz/pages/siswa/pages/siswa_level1_view.dart';

import '../../../app/custom_transition.dart';
import '../../../widgets/custom_level_carousel.dart';
import '../../guru/widget/data_guru.dart';
import 'siswa_level2_view.dart';
import 'siswa_level3_view.dart';

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
        middleBuilder:
            (level) => Image.asset(level['image'], ),
        onLevelTap: (level, index) {
          switch (index) {
            case 0:
              Navigator.push(context, SlidePageRoute(page: SiswaLevel1View()));
              break;
            case 1:
              Navigator.push(context, SlidePageRoute(page: SiswaLevel2View()));
              break;
            case 2:
              Navigator.push(context, SlidePageRoute(page: SiswaLevel3View()));
              break;
          }
        },
      ),
    );
  }
}
