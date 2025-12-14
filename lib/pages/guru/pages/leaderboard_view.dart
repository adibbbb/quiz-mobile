import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:quiz/app/finite_state.dart';
import 'package:quiz/provider/authentication_provider.dart';
import 'package:quiz/provider/leaderboard_provider.dart';

import '../../../commons.dart';
import '../widget/custom_tab_bar.dart';

class LeaderboardView extends StatefulWidget {
  const LeaderboardView({super.key});

  @override
  State<LeaderboardView> createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var prov = context.read<LeaderboardProvider>();
      prov.fetchLeaderboard("quiz_1");
    });
  }

  bool isMyScore(String username) {
    var prov = context.read<AuthenticationProvider>();
    return username.toLowerCase() == prov.user?.name.toLowerCase();
  }

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
                Expanded(
                  child: Consumer<LeaderboardProvider>(
                    builder: (context, prov, _) {
                      return CustomTabBar(
                        onTabChange: (index) {
                          var prov = context.read<LeaderboardProvider>();

                          if (index == 0) {
                            prov.fetchLeaderboard("quiz_1");
                          } else if (index == 1) {
                            prov.fetchLeaderboard("quiz_2");
                          } else if (index == 2) {
                            prov.fetchLeaderboard("quiz_3");
                          }
                        },
                        tabs: const ["LEVEL 1", "LEVEL 2", "LEVEL 3"],

                        children: [
                          _leaderboard(prov, "quiz_1"),
                          _leaderboard(prov, "quiz_2"),
                          _leaderboard(prov, "quiz_1"),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _leaderboard(LeaderboardProvider prov, String quizId) {
    if (prov.state.isFirstTry) {
      return Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.fromLTRB(17, 15, 17, 0),
        height: MediaQuery.of(context).size.height * 0.6,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(39),
          color: Color(0xffFFC578),
        ),
        child: CircularProgressIndicator(color: Colors.black),
      );
    }

    if (prov.state.isFailed) {
      return Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.fromLTRB(17, 15, 17, 0),
        height: MediaQuery.of(context).size.height * 0.6,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(39),
          color: Color(0xffFFC578),
        ),
        child: Text(prov.error ?? ""),
      );
    }

    var leaderboard = prov.entries;

    return Column(
      children: [
        _rankLevel(),
        Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.fromLTRB(17, 15, 17, 0),
          height: MediaQuery.of(context).size.height * 0.6,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(39),
            color: Color(0xffFFC578),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child:
                leaderboard.isEmpty
                    ? Center(child: Text("Belum ada siswa yang mengisi!"))
                    : ListView.separated(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      itemBuilder: (context, index) {
                        var data = leaderboard.elementAtOrNull(index);

                        return _nameStudent(
                          no: '${index + 1}',
                          name: data?.userName ?? "",
                          points: "${data?.score ?? 0}",
                          isYou: isMyScore(data?.userName ?? "--"),
                        );
                      },
                      separatorBuilder: (context, index) => kGap10,
                      itemCount: leaderboard.length,
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
      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isYou ? Color(0xffEF8D23) : Color(0xffF4A261),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(no),

          Flexible(
            child: AutoSizeText(
              textAlign: TextAlign.left,
              isYou ? '$name (You)' : name,
              maxLines: 2,
              minFontSize: 12,
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
