import 'package:provider/provider.dart';
import 'package:quiz/app/navigator_keys.dart';

import 'commons.dart';
import 'pages/login_page/default_login_view.dart';
import 'provider/auth_provider.dart';
import 'provider/soal_guru_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TeacherQuestionProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'QuizGo', home: const DefaultLoginView()),
    );
  }
}
