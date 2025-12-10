import '../../../commons.dart';


final List<Map<String, dynamic>> levelData = [
  {
    'title': 'EASY START',
    'desc': 'Matematika Dasar, Bahasa Indonesia, Pengetahuan Umum',
    'color': AppColors.blue,
    'image' : AppImages.imgLevel1
  },
  {
    'title': 'MEDIUM CHALLENGE',
    'desc': 'Matematika Dasar, Bahasa Indonesia, IPA, dan Pengetahuan Umum.',
    'color': AppColors.orange,
    'image' : AppImages.imgLevel2
  },
  {
    'title': 'HARD MODE',
    'desc':
        'Matematika Dasar, Bahasa Indonesia, IPA, IPS, dan Pengetahuan Umum.',
    'color': AppColors.blueDongker,
    'image' : AppImages.imgLevel3
  },
];

LinearGradient backgroundGradient(int index) {
  switch (index) {
    case 0:
      return const LinearGradient(
        colors: [
          AppColors.white,
          Color(0xFFE8F6FF), // putih kebiruan soft
          AppColors.blue,
        ],
        stops: [0.0, 1.0, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

    case 1:
      return const LinearGradient(
        colors: [
          AppColors.white,
          Color(0xFFFFF2E5), // putih ke orange soft
          AppColors.orange,
        ],
        stops: [0.0, 1.0, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

    default:
      return const LinearGradient(
        colors: [
          AppColors.white,
          Color(0xFFE6EBF7), // putih ke biru dongker soft
          AppColors.blueDongker,
        ],
        stops: [0.0, 1.0, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
  }
}

DecorationImage backgroundLevel(int index) {
  switch (index) {
    case 0:
      return DecorationImage(
        image: AssetImage(AppImages.imgBgLevel1),
        fit: BoxFit.cover,
      );

    case 1:
      return DecorationImage(
        image: AssetImage(AppImages.imgBgLevel2),
        fit: BoxFit.cover,
      );
    default:
      return DecorationImage(
        image: AssetImage(AppImages.imgBgLevel3),
        fit: BoxFit.cover,
      );
  }
}
