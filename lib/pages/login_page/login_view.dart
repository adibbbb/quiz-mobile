import 'package:auto_size_text/auto_size_text.dart';
import 'package:quiz/app/custom_transition.dart';
import 'package:quiz/app/extensions.dart';

import '../../commons.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../guru/pages/guru_home_view.dart';
import '../siswa/pages/siswa_home_view.dart';

enum LoginViewType { siswa, guru }

class LoginView extends StatefulWidget {
  final LoginViewType type;
  const LoginView({super.key, this.type = LoginViewType.siswa});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case LoginViewType.siswa:
        return _loginSiswa();
      case LoginViewType.guru:
        return _loginGuru();
    }
  }

  Widget _loginSiswa() {
    final TextEditingController namaController = TextEditingController();
    final TextEditingController kelasController = TextEditingController();
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.unfocusKeyboard();
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.imgBgLevel0),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bool isTablet = constraints.maxWidth >= 600;

                final double sizeText = isTablet ? 32 : 20;
                final double sizeTextImages = isTablet ? 100 : 70;
                final double sizeImages = isTablet ? 320 : 250;
                final double sizeButton = isTablet ? 70 : 50;

                return ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    kGap30,
                    AutoSizeText(
                      'PLAY',
                      textAlign: TextAlign.center,
                      style: AppStyles.montserrat32Bold.copyWith(
                        fontSize: sizeText,
                        color: AppColors.white,
                      ),
                    ),
                    kGap20,
                    Image.asset(height: sizeTextImages, AppImages.imgQuizGo),

                    kGap25,
                    Image.asset(height: sizeImages, AppImages.imgLogin),

                    kGap34,

                    CustomTextFormField(
                      controller: namaController,
                      label: 'Nama :',
                      hintText: 'Masukkan nama anda',
                    ),
                    kGap18,
                    CustomTextFormField(
                      controller: kelasController,
                      label: 'Kelas :',
                      hintText: 'Masukkan Kelas anda',
                    ),

                    kGap18,
                    CustomButton(
                      height: sizeButton,
                      text: 'Lets Go',
                      onPressed: () {
                        Navigator.push(
                          context,
                          SlidePageRoute(page: SiswaHomeView()),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginGuru() {
    final TextEditingController namaController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.unfocusKeyboard();
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.imgBgLevel0),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bool isTablet = constraints.maxWidth >= 600;

                final double sizeText = isTablet ? 32 : 20;
                final double sizeTextImages = isTablet ? 100 : 70;
                final double sizeImages = isTablet ? 320 : 250;
                final double sizeButton = isTablet ? 70 : 50;

                return ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    kGap30,
                    AutoSizeText(
                      'HELLO TEACHER',
                      textAlign: TextAlign.center,
                      style: AppStyles.montserrat32Bold.copyWith(
                        fontSize: sizeText,
                        color: AppColors.white,
                      ),
                    ),
                    kGap20,
                    Image.asset(height: sizeTextImages, AppImages.imgQuizGo),

                    kGap25,
                    Image.asset(height: sizeImages, AppImages.imgLogin),

                    kGap34,

                    CustomTextFormField(
                      controller: namaController,
                      label: 'Nama :',
                      hintText: 'Masukkan nama anda',
                    ),
                    kGap18,
                    CustomPasswordTextFormField(
                      controller: passwordController,
                      label: 'Password :',
                      hintText: 'Masukkan Password anda',
                    ),
                    kGap18,
                    CustomButton(
                      height: sizeButton,
                      text: 'Lets Go',
                      onPressed: () {
                        Navigator.push(
                          context,
                          SlidePageRoute(page: GuruHomeView()),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
