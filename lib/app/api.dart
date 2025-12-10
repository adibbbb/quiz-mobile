// import 'package:dio/dio.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// import '../services/shared_pref_services.dart';

// class Api {
//   static final Api _instance = Api._internal();
//   late Dio dio;

//   factory Api() => _instance;

//   Api._internal() {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: 'https://api.tixboom.com/api/',
//         connectTimeout: const Duration(seconds: 10),
//         receiveTimeout: const Duration(seconds: 10),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//       ),
//     );

//     // Always inject latest token before request
//     dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           final prefs = await SharedPreferencesServices.getInstance();
//           final token = prefs.readToken; // get from SharedPreferences
//           if (token.isNotEmpty) {
//             options.headers['Authorization'] = 'Bearer $token';
//           }
//           return handler.next(options);
//         },
//       ),
//     );

//     dio.interceptors.add(
//       PrettyDioLogger(
//         requestHeader: true,
//         requestBody: true,
//         responseHeader: true,
//         responseBody: true,
//         compact: true,
//       ),
//     );
//   }
// }
