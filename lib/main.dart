import 'package:flutter/material.dart';

import 'constants.dart';
import 'home_screen.dart';
import 'screen/question_screen.dart';
import 'screen/result_screen.dart';
import 'splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        ScreenName.home: (context) => const HomeScreen(),
        ScreenName.question: (context) => const QuestionScreen(),
        ScreenName.result: (context) => const ResultScreen(),
      },
    );
  }
}
