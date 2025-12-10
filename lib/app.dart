import 'package:provider/provider.dart';

import 'commons.dart';
import 'pages/login_page/default_login_view.dart';
import 'provider/pertanyaan_guru_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TeacherQuestionProvider()),
      ],
      child: MaterialApp(title: 'QuizGo', home: const DefaultLoginView()),
    );
  }
}
