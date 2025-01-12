import 'package:flutter/material.dart';

import '../constants.dart';
import '../dependencies.dart';
import '../model/preference/user_reference.dart';
import '../theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final userRef = injector.get<UserReference>();
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
            Image.asset(getImagePath(arg)),
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
