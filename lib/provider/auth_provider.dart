import 'package:quiz/app/custom_transition.dart';

import '../app/finite_state.dart';
import '../app/navigator_keys.dart';
import '../commons.dart';
import '../pages/guru/pages/guru_home_view.dart';
import '../pages/login_page/login_view.dart';
import '../services/auth_services.dart';
import '../widgets/custom_dialog.dart';

class AuthProvider extends ChangeNotifier {
  MyState state = MyState.initial;

  AuthServices authService = AuthServices();

  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  Map<String, dynamic>? loggedGuru;

  Future<void> login() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    state = MyState.loading;
    notifyListeners();

    formKey.currentState?.save();

    print("ID DIKIRIM    : $email");
    print("PASS DIKIRIM  : $password");

    final result = await authService.signInWithId(email, password);

    result.fold(
      (error) {
        state = MyState.failed;
        notifyListeners();

        var context = navigatorKey.currentState?.context;
        if (context != null) {
          showErrorDialog(context, error.message);
        }
      },
      (successData) {
        loggedGuru = successData;

        state = MyState.loaded;
        notifyListeners();

        var context = navigatorKey.currentState?.context;
        if (context != null) {
          showSuccessDialog(context, "Login berhasil!");
          Future.delayed(const Duration(milliseconds: 500)).then((_) {
            context.slideRemoveUntil(GuruHomeView());
          });
        }
      },
    );
  }

  void logout() {
    loggedGuru = null; 
    state = MyState.initial;
    notifyListeners();

    var context = navigatorKey.currentState?.context;
    if (context != null) {
      context.slideRemoveUntil(LoginView(type: LoginViewType.guru));
    }
  }
}
