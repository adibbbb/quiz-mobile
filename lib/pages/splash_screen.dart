import 'package:provider/provider.dart';
import 'package:quiz/app/custom_transition.dart';
import 'package:quiz/commons.dart';

import '../provider/authentication_provider.dart';
import 'guru/pages/guru_home_view.dart';
import 'login_page/default_login_view.dart';
import 'siswa/pages/siswa_home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // panggil check session

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var auth = context.read<AuthenticationProvider>();
      Future.delayed(
        Durations.extralong1,
        // ignore: use_build_context_synchronously
        () => auth.checkSession().then((value) {
          redirect(auth);
        }),
      );
    });
  }

  void redirect(AuthenticationProvider auth) {
    switch (auth.status) {
      case AuthStatus.authenticatedTeacher:
        context.fadeRemoveUntil(GuruHomeView());
      case AuthStatus.authenticatedStudent:
        context.fadeRemoveUntil(SiswaHomeView());
      case AuthStatus.unauthenticated:
        context.fadeRemoveUntil(DefaultLoginView());

      case AuthStatus.unknown:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (_, auth, __) {
        return Container(
          color: Colors.white,
          child: const Center(
            child: CircularProgressIndicator(color: Colors.black),
          ),
        );
      },
    );
  }
}
