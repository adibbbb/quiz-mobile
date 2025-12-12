import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:quiz/app/custom_transition.dart';
import 'package:quiz/app/extensions.dart';

import '../../app/finite_state.dart';
import '../../commons.dart';
import '../../provider/auth_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';

import 'default_login_view.dart';

enum LoginViewType { siswa, guru }

class LoginView extends StatefulWidget {
  final LoginViewType type;
  const LoginView({super.key, this.type = LoginViewType.siswa});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Controller Guru
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Controller Siswa
  final TextEditingController namaController = TextEditingController();
  final TextEditingController kelasController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
    var authProv = context.read<AuthProvider>();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.unfocusKeyboard();
      },
      child: Scaffold(
        body: Form(
          key: authProv.formKey,
          child: Container(
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
                        validator: (value) {
                          if ((value ?? '').trim().isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          authProv.namaSiswa = value ?? "";
                        },
                      ),
                      kGap18,
                      CustomTextFormField(
                        controller: kelasController,
                        label: 'Kelas :',
                        hintText: 'Masukkan Kelas anda',
                        validator: (value) {
                          if ((value ?? '').trim().isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          authProv.kelasSiswa = value ?? "";
                        },
                      ),

                      kGap18,
                      Consumer<AuthProvider>(
                        builder: (context, prov, _) {
                          return CustomButton(
                            height: sizeButton,
                            text:
                                prov.state == MyState.loading
                                    ? "Loading..."
                                    : "Lets Go",
                            onPressed:
                                prov.state == MyState.loading
                                    ? null
                                    : prov.loginSiswaWithValidation
                                    
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
      ),
    );
  }

  Widget _loginGuru() {
    var authProv = context.read<AuthProvider>();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.unfocusKeyboard();
      },
      child: Scaffold(
        body: Form(
          key: authProv.formKey,
          child: Container(
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
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            context.slideRemoveUntil(DefaultLoginView());
                          },
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: AppColors.white,
                            size: 25,
                          ),
                        ),
                      ),
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
                        controller: emailController,
                        label: 'ID :',
                        hintText: 'Masukkan id anda',
                        validator: (value) {
                          if ((value ?? '').trim().isEmpty) {
                            return 'id tidak boleh kosong';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          authProv.email = value ?? "";
                        },
                      ),
                      kGap18,
                      CustomPasswordTextFormField(
                        controller: passwordController,
                        label: 'Password :',
                        hintText: 'Masukkan Password anda',
                        validator: (value) {
                          if ((value ?? '').trim().isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          authProv.password = value ?? "";
                        },
                      ),
                      kGap18,
                      Consumer<AuthProvider>(
                        builder: (context, prov, _) {
                          return CustomButton(
                            height: sizeButton,
                            text:
                                prov.state == MyState.loading
                                    ? "Loading..."
                                    : "Lets Go",
                            onPressed:
                                prov.state == MyState.loading
                                    ? null
                                    : authProv.loginGuru,
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
      ),
    );
  }
}
