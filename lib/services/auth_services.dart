import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:quiz/app/error_handler.dart';
import '../app/app_typedef.dart';
import '../app/error/failure.dart';

class AuthServices {
  AuthServices._internal();
  static final _singleton = AuthServices._internal();
  factory AuthServices() => _singleton;

  final FirebaseFirestore _db = FirebaseFirestore.instance;


  ResultFuture<Map<String, dynamic>> signInWithId(
    String id,
    String password,
  ) async {
    try {
      final doc = await _db.collection("gurus").doc(id).get();

      if (!doc.exists) {
        return const Left(
          APIFailure(message: "ID tidak ditemukan", statusCode: 404),
        );
      }

      final data = doc.data()!;
      final storedPassword = data["password"];

      if (storedPassword != password) {
        return const Left(
          APIFailure(message: "Password salah", statusCode: 401),
        );
      }

      return Right(data);
    } catch (e) {
      return Left(ErrorHandler.map(e));
    }
  }
}
