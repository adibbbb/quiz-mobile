import 'package:flutter/material.dart';
import 'package:quiz/app/extensions.dart';
import 'package:quiz/app/navigator_keys.dart';

import '../app/finite_state.dart';
import '../models/app_user.dart';
import '../services/authentication_services.dart';

enum AuthStatus {
  unknown,
  authenticatedTeacher,
  authenticatedStudent,
  unauthenticated,
}

class AuthenticationProvider extends ChangeNotifier {
  final AuthenticationServices _service;

  AuthenticationProvider(this._service);

  // ================== STATE ==================

  MyState _state = MyState.initial;
  MyState get state => _state;

  AuthStatus _status = AuthStatus.unknown;
  AuthStatus get status => _status;

  AppUser? _user;
  AppUser? get user => _user;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // ================== INTERNAL ==================

  void _setState(MyState value) {
    _state = value;
    notifyListeners();
  }

  void _setAuthStatus(AuthStatus value) {
    _status = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  // ==========================================================
  // 🔍 CEK SESSION (APP START / SPLASH)
  // ==========================================================
  Future<void> checkSession() async {
    _setState(MyState.loading);
    _setError(null);

    try {
      // 1️⃣ Guru (Firebase Auth)
      if (_service.currentFirebaseUser != null) {
        _setAuthStatus(AuthStatus.authenticatedTeacher);
        _setState(MyState.loaded);
        return;
      }

      // 2️⃣ Siswa (Local session)
      final isStudent = await _service.isStudentLoggedIn();
      if (isStudent) {
        _setAuthStatus(AuthStatus.authenticatedStudent);
        _setState(MyState.loaded);
        return;
      }

      // 3️⃣ Belum login
      _setAuthStatus(AuthStatus.unauthenticated);
      _setState(MyState.loaded);
    } catch (_) {
      _setState(MyState.failed);
    }
  }

  // ==========================================================
  // 👨‍🏫 LOGIN GURU
  // ==========================================================
  Future<bool> loginTeacher({
    required String email,
    required String password,
  }) async {
    _setState(MyState.loading);
    _setError(null);

    final result = await _service.loginTeacher(
      email: email,
      password: password,
    );

    return result.when(
      success: (user) {
        _user = user;
        _setAuthStatus(AuthStatus.authenticatedTeacher);
        _setState(MyState.loaded);
        return true;
      },
      failure: (message) {
        _setError(message);
        _setState(MyState.failed);
        navigatorKey.currentContext?.showErrorSnackBar(message);
        return false;
      },
    );
  }

  // ==========================================================
  // 👦 LOGIN SISWA
  // ==========================================================
  Future<bool> loginStudent({
    required String name,
    required String className,
  }) async {
    _setState(MyState.loading);
    _setError(null);

    final result = await _service.loginStudent(
      name: name,
      className: className,
    );

    return result.when(
      success: (user) {
        _user = user;
        _setAuthStatus(AuthStatus.authenticatedStudent);
        _setState(MyState.loaded);
        return true;
      },
      failure: (message) {
        _setError(message);
        _setState(MyState.failed);
        navigatorKey.currentContext?.showErrorSnackBar(message);
        return false;
      },
    );
  }

  // ==========================================================
  // 🚪 LOGOUT
  // ==========================================================
  Future<void> logout() async {
    _setState(MyState.loading);
    _setError(null);

    final result = await _service.logout();

    result.when(
      success: (_) {
        _user = null;
        _setAuthStatus(AuthStatus.unauthenticated);
        _setState(MyState.loaded);
      },
      failure: (message) {
        _setError(message);
        _setState(MyState.failed);
      },
    );
  }
}
