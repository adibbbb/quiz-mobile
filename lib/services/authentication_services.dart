import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/result.dart';
import '../models/app_user.dart';

class AuthenticationServices {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  AuthenticationServices(this._auth, this._db);

  User? get currentFirebaseUser => _auth.currentUser;

  // ==========================================================
  // 🔍 CEK SESSION SISWA
  // ==========================================================
  Future<bool> isStudentLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('student_uid');
  }

  // ==========================================================
  // 👨‍🏫 LOGIN GURU
  // ==========================================================
  ResultFuture<AppUser> loginTeacher({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = cred.user!.uid;
      final doc = await _db.collection('users').doc(uid).get();

      if (!doc.exists) {
        return const Failure('Data guru tidak ditemukan');
      }

      return Success(AppUser.fromMap(uid, doc.data()!));
    } on FirebaseAuthException catch (e) {
      return Failure(_mapAuthError(e));
    } catch (_) {
      return const Failure('Terjadi kesalahan');
    }
  }

  // ==========================================================
  // 👦 LOGIN SISWA (ANONYMOUS + LOCAL BACKUP)
  // ==========================================================
  ResultFuture<AppUser> loginStudent({
    required String name,
    required String className,
  }) async {
    try {
      if (name.trim().isEmpty || className.trim().isEmpty) {
        return Failure("Wajib isi nama dan kelas");
      }

      final cred = await _auth.signInAnonymously();
      final uid = cred.user!.uid;

      final userData = {
        'name': name,
        'class': className,
        'role': 'student',
        'createdAt': FieldValue.serverTimestamp(),
      };

      await _db.collection('users').doc(uid).set(userData);

      final prefs = await SharedPreferences.getInstance();
      // 🔥 LOCAL BACKUP (WAJIB)
      await prefs.setString('student_uid', uid);
      await prefs.setString('student_name', name);
      await prefs.setString('student_class', className);

      return Success(
        AppUser(id: uid, name: name, role: 'student', className: className),
      );
    } on FirebaseAuthException catch (e) {
      return Failure(_mapAuthError(e));
    } catch (_) {
      return const Failure('Terjadi kesalahan');
    }
  }

  // ==========================================================
  // 🚪 LOGOUT
  // ==========================================================
  ResultFuture<void> logout() async {
    try {
      await _auth.signOut();
      final prefs = await SharedPreferences.getInstance();

      // 🔥 CLEAR LOCAL SESSION
      await prefs.remove('student_uid');
      await prefs.remove('student_name');
      await prefs.remove('student_class');

      return const Success(null);
    } catch (_) {
      return const Failure('Gagal logout');
    }
  }
}

String _mapAuthError(FirebaseAuthException e) {
  switch (e.code) {
    case 'invalid-email':
      return 'Format email tidak valid';

    case 'user-disabled':
      return 'Akun ini telah dinonaktifkan';

    case 'user-not-found':
    case 'wrong-password':
    case 'invalid-credential':
      return 'Email atau password salah';

    case 'too-many-requests':
      return 'Terlalu banyak percobaan, coba lagi nanti';

    case 'network-request-failed':
      return 'Tidak ada koneksi internet';

    case 'operation-not-allowed':
      return 'Login belum diaktifkan oleh admin';

    default:
      return 'Gagal login, coba lagi';
  }
}
