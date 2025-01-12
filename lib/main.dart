import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'constants.dart';
import 'dependencies.dart';
import 'home_screen.dart';
import 'model/preference/user_reference.dart';
import 'screen/question_screen.dart';
import 'screen/result_screen.dart';
import 'splash_screen.dart';
import 'theme/app_text_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('vi');
  // final userRef = injector.get<UserReference>();

  void _changeLanguage(String languageCode) {
    setState(() {
      _locale = Locale(languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        textTheme: AppTextTheme.textTheme,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        ScreenName.home: (context) => HomeScreen(changeLanguage: _changeLanguage),
        ScreenName.question: (context) => const QuestionScreen(),
        ScreenName.result: (context) => const ResultScreen(),
      },
    );
  }
}
