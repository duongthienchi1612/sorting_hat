import 'package:flutter/material.dart';

import '../constants.dart';
import '../dependencies.dart';
import '../model/preference/user_reference.dart';

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

    return Scaffold(
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
                  await userRef.setStatusQuiz(StatusQuiz.inProgress);
                  await userRef.setCurrentQuestion(1);
                  Navigator.popUntil(context, ModalRoute.withName(ScreenName.home));
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
              'Discovery your house',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'Caudex',
                fontWeight: FontWeight.bold,
                color: Color(0xFFFBE4C5),
              ),
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
