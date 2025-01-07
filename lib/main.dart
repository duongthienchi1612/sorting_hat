import 'package:flutter/material.dart';
import 'package:sorting_hat/screen/question_screen.dart';

import 'home_screen.dart';
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
        '/home': (context) => const HomeScreen(),
        '/question': (context) => const QuestionScreen(),
        '/result': (context) => const HomeScreen(),
      },
      // home: HomeScreen(),
    );
  }
}
