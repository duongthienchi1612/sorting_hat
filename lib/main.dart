import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'business/master_data_business.dart';
import 'constants.dart';
import 'dependencies.dart';
import 'preference/user_reference.dart';
import 'home_screen.dart';
import 'screen/question_screen.dart';
import 'screen/result_screen.dart';
import 'splash_screen.dart';
import 'theme/app_colors.dart';
import 'theme/app_text_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Cấu hình để ẩn thanh điều hướng và thanh trạng thái
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [],
  );
  
  // Khóa hướng màn hình
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  
  final initialLanguage = await UserReference().getLanguage() ?? 'en';
  runApp(MyApp(initialLanguage: initialLanguage));
}

class MyApp extends StatefulWidget {
  final String initialLanguage;
  const MyApp({super.key, required this.initialLanguage});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = Locale(widget.initialLanguage);
  }

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
        // Enhance with more theme customization
        colorScheme: ColorScheme.dark(
          primary: AppColors.mainColor,
          secondary: AppColors.goldenYellow,
          surface: Colors.black,
          background: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.black,
        // Customize buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.mainColor,
            foregroundColor: AppColors.redBorder,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: BorderSide(color: AppColors.darkBrown, width: 2),
            ),
            elevation: 5,
          ),
        ),
        // Dialog theme
        dialogTheme: DialogTheme(
          backgroundColor: AppColors.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: AppColors.darkBrown, width: 2),
          ),
          elevation: 10,
        ),
        // Icon theme
        iconTheme: IconThemeData(
          color: AppColors.mainColor,
          size: 24,
        ),
        // Text button theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.redBorder,
            textStyle: TextStyle(
              fontFamily: 'Caudex',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Customize scrollbars
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(AppColors.mainColor.withOpacity(0.6)),
          thickness: MaterialStateProperty.all(6),
          radius: const Radius.circular(10),
        ),
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
