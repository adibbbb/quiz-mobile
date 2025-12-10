import 'package:auto_size_text/auto_size_text.dart';

import '../../../commons.dart';
import '../widget/custom_tab_bar.dart';

class LeaderboardView extends StatefulWidget {
  const LeaderboardView({super.key});

  @override
  State<LeaderboardView> createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.imgBgLevel0),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                _appBar(context),
                kGap12,
                CustomTabBar(
                  tabs: const ["LEVEL 1", "LEVEL 2", "LEVEL 3"],
                  children: [_level1(), _level2(), _level3()],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _level1() {
    return Column(
      children: [
        _rankLevel(),
        Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.fromLTRB(17, 15, 17, 0),
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(39),
            color: Color(0xffFFC578),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: List.generate(10, (index) {
                return _nameStudent(
                  no: '${index + 1}',
                  name: 'Mochammad Adib Soedibyo',
                  points: '${100 - index * 10}',
                  isYou: index == 0,
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
  Widget _level2() {
    return Column(
      children: [
        _rankLevel(),
        Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.fromLTRB(17, 15, 17, 0),
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(39),
            color: Color(0xffFFC578),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: List.generate(10, (index) {
                return _nameStudent(
                  no: '${index + 1}',
                  name: 'Mochammad Adib Soedibyo',
                  points: '${100 - index * 10}',
                  isYou: index == 8,
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _level3() {
    return Column(
      children: [
        _rankLevel(),
        Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.fromLTRB(17, 15, 17, 0),
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(39),
            color: Color(0xffFFC578),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: List.generate(10, (index) {
                return _nameStudent(
                  no: '${index + 1}',
                  name: 'Mochammad Adib Soedibyo',
                  points: '${100 - index * 10}',
                  isYou: index == 4,
                );
              }),
            ),
          ),
        ),
      ],
    );
  }


  Container _nameStudent({
    required String no,
    required String name,
    required String points,
    bool isYou = false,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isYou ? Color(0xffEF8D23) : Color(0xffF4A261),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(no),
          isYou
              ? Flexible(
                child: AutoSizeText(
                  '$name (You)',
                  maxLines: 2,
                  minFontSize: 10,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              )
              : Flexible(
                child: AutoSizeText(
                  name,
                  maxLines: 2,
                  minFontSize: 10,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
          Text(points),
        ],
      ),
    );
  }

  Container _rankLevel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(42),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff000000).withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'RANK',
            style: AppStyles.poppins12Bold.copyWith(
              color: AppColors.blueDongker,
            ),
          ),
          Text(
            'NAMA',
            style: AppStyles.poppins12Bold.copyWith(
              color: AppColors.blueDongker,
            ),
          ),
          Text(
            'POINTS',
            style: AppStyles.poppins12Bold.copyWith(
              color: AppColors.blueDongker,
            ),
          ),
        ],
      ),
    );
  }

  Row _appBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.white,
            size: 25,
          ),
        ),
        Image.asset(AppImages.imgLeaderBoard, height: 55, width: 200),
        kGap25,
      ],
    );
  }
}
