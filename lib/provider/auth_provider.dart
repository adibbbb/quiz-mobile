import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz/app/custom_transition.dart';

import '../app/finite_state.dart';
import '../app/navigator_keys.dart';
import '../commons.dart';
import '../pages/guru/pages/guru_home_view.dart';
import '../pages/login_page/login_view.dart';
import '../pages/siswa/pages/siswa_home_view.dart';
import '../services/auth_services.dart';
import '../widgets/custom_dialog.dart';

class AuthProvider extends ChangeNotifier {
  MyState state = MyState.initial;

  AuthServices authService = AuthServices();

  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  Map<String, dynamic>? loggedGuru;

  String namaSiswa = '';
  String kelasSiswa = '';

  //------------------------------------------------------
  // PROVIDER GURU
  //------------------------------------------------------
  Future<void> loginGuru() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    state = MyState.loading;
    notifyListeners();

    formKey.currentState?.save();

    final result = await authService.signInGuru(email, password);

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
            // ignore: use_build_context_synchronously
            context.slideRemoveUntil(GuruHomeView());
          });
        }
      },
    );
  }

  void logoutGuru() {
    loggedGuru = null;
    state = MyState.initial;
    notifyListeners();

    var context = navigatorKey.currentState?.context;
    if (context != null) {
      context.slideRemoveUntil(LoginView(type: LoginViewType.guru));
    }
  }

  //------------------------------------------------------
  // PROVIDER SISWA
  //------------------------------------------------------
  Future<void> loginSiswaWithValidation() async {
    // validasi form
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    // simpan value onSaved
    formKey.currentState?.save();

    // panggil loginSiswa
    await loginSiswa();
  }

  Future<void> loginSiswa() async {
    if (namaSiswa.trim().isEmpty || kelasSiswa.trim().isEmpty) {
      var context = navigatorKey.currentState?.context;
      if (context != null) {
        showErrorDialog(context, "Nama dan Kelas tidak boleh kosong");
      }
      return;
    }

    state = MyState.loading;
    notifyListeners();

    try {
      // Simpan ke Firestore
      await FirebaseFirestore.instance.collection('siswa').add({
        'nama': namaSiswa.trim(),
        'kelas': kelasSiswa.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      state = MyState.loaded;
      notifyListeners();

      var context = navigatorKey.currentState?.context;
      if (context != null) {
        // ignore: use_build_context_synchronously
        showSuccessDialog(context, "berhasil masuk!");
        Future.delayed(const Duration(milliseconds: 500)).then((_) {
          // ignore: use_build_context_synchronously
          context.slideRemoveUntil(SiswaHomeView());
        });
      }
    } catch (e) {
      state = MyState.failed;
      notifyListeners();

      var context = navigatorKey.currentState?.context;
      if (context != null) {
        // ignore: use_build_context_synchronously
        showErrorDialog(context, "Gagal menyimpan data: $e");
      }
    }
  }
}
