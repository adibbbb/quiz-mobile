
import '../../../commons.dart';

class LevelColors {
  static Color getBackground(int level) {
    return Colors.white; // untuk container background
  }

  static Color getCircleAvatar(int level) {
    switch (level) {
      case 1:
        return AppColors.blue;
      case 2:
        return AppColors.orange;
      case 3:
        return AppColors.blueDongker;
      default:
        return AppColors.blue;
    }
  }

  static Color getButtonNext(int level) {
    switch (level) {
      case 1:
        return AppColors.blue;
      case 2:
        return AppColors.orange;
      case 3:
        return AppColors.blueDongker;
      default:
        return AppColors.blue;
    }
  }

  static String getImgBgLevel(String bgLevel){
    switch (bgLevel){
      case '1':
      return AppImages.imgbgsoalLevel1;
      case '2':
      return AppImages.imgbgsoalLevel2;
      case '3':
      return AppImages.imgbgsoalLevel3;
       default:
        return AppImages.imgbgsoalLevel1;
    }
  }
}
