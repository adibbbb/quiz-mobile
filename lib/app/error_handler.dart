// // ignore_for_file: constant_identifier_names

// import 'dart:async';
// import 'dart:io';

// import 'package:dio/dio.dart';

// import 'error/failure.dart';

// class ErrorHandler implements Exception {
//   late Failure failure;

//   ErrorHandler.handle(
//     dynamic error, {
//     List<String> messageKeys = const ['MESSAGE', 'msg', 'message', 'error'],
//     bool preferNestedMessage = false,
//   }) {
//     if (error is DioException) {
//       failure = _handleErrorDio(error, messageKeys, preferNestedMessage);
//     } else if (error is FormatException) {
//       failure = DataSource.PARSING_ERROR.getFailure();
//     } else if (error is TypeError) {
//       failure = DataSource.WRONG_DATA_TYPE.getFailure();
//     } else if (error is SocketException) {
//       failure = DataSource.NO_INTERNET_CONNECTION.getFailure();
//     } else if (error is TimeoutException) {
//       failure = DataSource.CONNECT_TIMEOUT.getFailure();
//     } else {
//       failure = DataSource.DEFAULT.getFailure();
//     }
//   }
// }

// Failure _handleErrorDio(
//   DioException error,
//   List<String> messageKeys,
//   bool preferNestedMessage,
// ) {
//   switch (error.type) {
//     case DioExceptionType.badResponse:
//       final statusCode = error.response?.statusCode ?? 0;
//       final responseData = error.response?.data;
//       final message = _extractErrorMessageFlexible(
//         responseData,
//         messageKeys,
//         preferNestedMessage,
//       );

//       switch (statusCode) {
//         case 400:
//           return APIFailure(
//             statusCode: statusCode,
//             message: message.isNotEmpty ? message : ResponseMessage.BAD_REQUEST,
//           );
//         case 401:
//           return DataSource.UNAUTORISED.getFailure(massage: message);
//         case 403:
//           return DataSource.FORBIDDEN.getFailure(massage: message);
//         case 404:
//           return DataSource.NOT_FOUND.getFailure(massage: message);
//         case 500:
//           return DataSource.INTERNAL_SERVER_ERROR.getFailure();
//         default:
//           return DataSource.DEFAULT.getFailure(massage: message);
//       }

//     case DioExceptionType.connectionError:
//       return DataSource.NO_INTERNET_CONNECTION.getFailure();
//     case DioExceptionType.connectionTimeout:
//       return DataSource.CONNECT_TIMEOUT.getFailure();
//     case DioExceptionType.sendTimeout:
//       return DataSource.SEND_TIMEOUT.getFailure();
//     case DioExceptionType.receiveTimeout:
//       return DataSource.RECIEVE_TIMEOUT.getFailure();
//     case DioExceptionType.cancel:
//       return DataSource.CANCEL.getFailure();
//     default:
//       return DataSource.DEFAULT.getFailure();
//   }
// }

// /// Menangani ekstraksi pesan error dari response JSON dengan struktur fleksibel.
// ///
// /// [data] adalah objek JSON response dari server.
// /// [keys] adalah daftar key yang memungkinkan untuk memuat pesan error (contoh: ['message', 'msg', 'MESSAGE']).
// /// [preferNested] menentukan apakah pencarian dimulai dari `data['data']` terlebih dahulu (nested)
// /// sebelum root-level, atau sebaliknya.
// ///
// /// Fungsi ini juga mempertimbangkan key 'data', 'DATA', 'Data', dan variasi lainnya untuk nested lookup.
// ///
// /// Return:
// /// - String pesan error pertama yang ditemukan berdasarkan urutan key.
// /// - Jika tidak ditemukan, akan mengembalikan string kosong ('').
// String _extractErrorMessageFlexible(
//   dynamic data,
//   List<String> keys,
//   bool preferNested,
// ) {
//   if (data is Map<String, dynamic>) {
//     // cari key nested 'data', bisa case-insensitive
//     final nestedKey = data.keys.firstWhere(
//       (k) => k.toLowerCase() == 'data',
//       orElse: () => '',
//     );

//     final nested = nestedKey.isNotEmpty ? data[nestedKey] : null;

//     if (preferNested && nested is Map<String, dynamic>) {
//       for (final key in keys) {
//         if (nested[key] != null) return nested[key].toString();
//       }
//     }

//     // kalau ga ketemu di nested atau preferNested false, coba di root
//     for (final key in keys) {
//       if (data[key] != null) return data[key].toString();
//     }

//     // kalau masih prefer nested, coba lagi nested di akhir
//     if (!preferNested && nested is Map<String, dynamic>) {
//       for (final key in keys) {
//         if (nested[key] != null) return nested[key].toString();
//       }
//     }
//   }

//   return '';
// }

// enum DataSource {
//   SUCCESS,
//   NO_CONTENT,
//   BAD_REQUEST,
//   FORBIDDEN,
//   UNAUTORISED,
//   NOT_FOUND,
//   INTERNAL_SERVER_ERROR,
//   CONNECT_TIMEOUT,
//   CANCEL,
//   RECIEVE_TIMEOUT,
//   SEND_TIMEOUT,
//   CACHE_ERROR,
//   NO_INTERNET_CONNECTION,
//   PARSING_ERROR, // contoh: gagal parse ketika int.parse, datetime.parse dll
//   WRONG_DATA_TYPE, // contoh cast paksa (misal as T) padahal salah, int a = "3"
//   DEFAULT,
// }

// extension DataSourceExtension on DataSource {
//   Failure getFailure({String massage = ''}) {
//     switch (this) {
//       case DataSource.SUCCESS:
//         return const APIFailure(
//           statusCode: ResponseCode.SUCCESS,
//           message: ResponseMessage.SUCCESS,
//         );
//       case DataSource.NO_CONTENT:
//         return const APIFailure(
//           statusCode: ResponseCode.NO_CONTENT,
//           message: ResponseMessage.NO_CONTENT,
//         );
//       case DataSource.BAD_REQUEST:
//         return const APIFailure(
//           statusCode: ResponseCode.BAD_REQUEST,
//           message: ResponseMessage.BAD_REQUEST,
//         );
//       case DataSource.FORBIDDEN:
//         return const APIFailure(
//           statusCode: ResponseCode.FORBIDDEN,
//           message: ResponseMessage.FORBIDDEN,
//         );
//       case DataSource.UNAUTORISED:
//         return APIFailure(
//           statusCode: ResponseCode.UNAUTORISED,
//           message: massage.isNotEmpty ? massage : ResponseMessage.DEFAULT,
//         );
//       case DataSource.NOT_FOUND:
//         return const APIFailure(
//           statusCode: ResponseCode.NOT_FOUND,
//           message: ResponseMessage.NOT_FOUND,
//         );
//       case DataSource.INTERNAL_SERVER_ERROR:
//         return const APIFailure(
//           statusCode: ResponseCode.INTERNAL_SERVER_ERROR,
//           message: ResponseMessage.INTERNAL_SERVER_ERROR,
//         );
//       case DataSource.CONNECT_TIMEOUT:
//         return const APIFailure(
//           statusCode: ResponseCode.CONNECT_TIMEOUT,
//           message: ResponseMessage.CONNECT_TIMEOUT,
//         );
//       case DataSource.CANCEL:
//         return const APIFailure(
//           statusCode: ResponseCode.CANCEL,
//           message: ResponseMessage.CANCEL,
//         );
//       case DataSource.RECIEVE_TIMEOUT:
//         return const APIFailure(
//           statusCode: ResponseCode.RECIEVE_TIMEOUT,
//           message: ResponseMessage.RECEIVE_TIMEOUT,
//         );
//       case DataSource.SEND_TIMEOUT:
//         return const APIFailure(
//           statusCode: ResponseCode.SEND_TIMEOUT,
//           message: ResponseMessage.SEND_TIMEOUT,
//         );
//       case DataSource.CACHE_ERROR:
//         return const APIFailure(
//           statusCode: ResponseCode.CACHE_ERROR,
//           message: ResponseMessage.CACHE_ERROR,
//         );
//       case DataSource.NO_INTERNET_CONNECTION:
//         return const APIFailure(
//           statusCode: ResponseCode.NO_INTERNET_CONNECTION,
//           message: ResponseMessage.NO_INTERNET_CONNECTION,
//         );

//       case DataSource.PARSING_ERROR:
//         return const APIFailure(
//           statusCode: -8,
//           message: "Parsing Error: Format response tidak sesuai",
//         );

//       case DataSource.WRONG_DATA_TYPE:
//         return const APIFailure(
//           statusCode: -8,
//           message: "Type Error: Tipe data response tidak sesuai",
//         );

//       case DataSource.DEFAULT:
//         return APIFailure(
//           statusCode: ResponseCode.DEFAULT,
//           message: massage.isNotEmpty ? massage : ResponseMessage.DEFAULT,
//         );
//     }
//   }
// }

// class ResponseCode {
//   static const int SUCCESS = 200; // success with data
//   static const int NO_CONTENT = 201; // success with no data (no content)
//   static const int BAD_REQUEST = 400; // failure, API rejected request
//   static const int UNAUTORISED = 401; // failure, user is not authorised
//   static const int FORBIDDEN = 403; //  failure, API rejected request
//   static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
//   static const int NOT_FOUND = 404; // failure, not found

//   // local status code
//   static const int CONNECT_TIMEOUT = -1;
//   static const int CANCEL = -2;
//   static const int RECIEVE_TIMEOUT = -3;
//   static const int SEND_TIMEOUT = -4;
//   static const int CACHE_ERROR = -5;
//   static const int NO_INTERNET_CONNECTION = -6;
//   static const int DEFAULT = -7;
// }

// class ResponseMessage {
//   static const String SUCCESS = "Berhasil";
//   static const String NO_CONTENT = "Tidak ada data";
//   static const String BAD_REQUEST = "Permintaan tidak valid";
//   static const String UNAUTHORISED = "Tidak terautentikasi";
//   static const String FORBIDDEN = "Tidak diizinkan";
//   static const String NOT_FOUND = "Tidak ditemukan";
//   static const String INTERNAL_SERVER_ERROR = "Kesalahan server";
//   static const String CONNECT_TIMEOUT = "Waktu koneksi habis";
//   static const String CANCEL = "Permintaan dibatalkan";
//   static const String RECEIVE_TIMEOUT = "Waktu menerima data habis";
//   static const String SEND_TIMEOUT = "Waktu mengirim data habis";
//   static const String CACHE_ERROR = "Kesalahan cache";
//   static const String NO_INTERNET_CONNECTION = "Tidak ada koneksi internet";
//   static const String DEFAULT = "Terjadi kesalahan";
// }
