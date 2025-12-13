import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'app/navigator_keys.dart';
import 'commons.dart';
import 'pages/splash_screen.dart';
import 'provider/authentication_provider.dart';
import 'provider/quiz_provider.dart';
import 'provider/teacher_provider.dart';
import 'services/authentication_services.dart';
import 'services/quizz_services.dart';
import 'services/teacher_services.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (_) => AuthenticationProvider(
                AuthenticationServices(firebaseAuth, firestore),
              ),
        ),

        //
        ChangeNotifierProvider(
          create: (_) => QuizProvider(QuizService(db: firestore)),
        ),
        //
        ChangeNotifierProvider(
          create: (_) => TeacherProvider(TeacherService(db: firestore)),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'QuizGo',
        home: const SplashView(),
      ),
    );
  }
}
