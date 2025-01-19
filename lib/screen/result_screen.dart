import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constants.dart';
import '../dependencies.dart';
import '../preference/user_reference.dart';
import '../theme/app_colors.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
  final userRef = injector.get<UserReference>();

  //animation
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // animation
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments! as String;
    final textTheme = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(ImagePath.background_result), fit: BoxFit.cover),
        ),
        padding: EdgeInsets.symmetric(vertical: 40),
        alignment: Alignment.center,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return Dialog(
                          backgroundColor: AppColors.mainColor,
                          child: SizedBox(
                            height: 140,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  localizations.retakeQuizTitle,
                                  textAlign: TextAlign.center,
                                  style: textTheme.bodyLarge!.copyWith(color: Colors.black),
                                ),
                                SizedBox(height: 12),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          await userRef.setStatusQuiz(StatusQuiz.inProgress);
                                          await userRef.setCurrentQuestion(1);
                                          Navigator.popAndPushNamed(context, ScreenName.home);
                                        },
                                        child: Text(
                                          localizations.yes,
                                          style: textTheme.bodyMedium!.copyWith(color: Colors.blue),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(ctx),
                                        child: Text(
                                          localizations.no,
                                          style: textTheme.bodyMedium!.copyWith(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                icon: Icon(
                  Icons.home,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            Spacer(),
            FadeTransition(
              opacity: _opacityAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Image.asset(
                  getImagePath(arg),
                ),
              ),
            ),
            Spacer(),
            Text(
              localizations.discoveryYourHouse,
              textAlign: TextAlign.center,
              style: textTheme.displayMedium,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  String getImagePath(String house) {
    switch (house) {
      case HouseName.gryffindor:
        return ImagePath.gryImage;
      case HouseName.ravenclaw:
        return ImagePath.ravImage;
      case HouseName.hufflepuff:
        return ImagePath.hufImage;
      case HouseName.slytherin:
        return ImagePath.slyImage;
      default:
        return '';
    }
  }
}
