import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'business/master_data_business.dart';
import 'constants.dart';
import 'dependencies.dart';
import 'model/preference/user_reference.dart';
import 'utilities/database_factory.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String statusQuiz;
  late String houseResult;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _requestPermissions() async {
    bool isAllGranted = true;
    if (Platform.isAndroid) {
      if (!(await Permission.manageExternalStorage.isGranted)) {
        final permission = await Permission.manageExternalStorage.request();
        isAllGranted = permission == PermissionStatus.granted;
      }
    }
    return isAllGranted;
  }

  Future<void> _initializeDependencies() async {
    await AppDependencies.initialize();
    final isAllGranted = await _requestPermissions();
    if (isAllGranted) {
      final databaseFactory = injector.get<DatabaseFactory>();
      await databaseFactory.initDatabase();

      final masterData = injector.get<MasterDataBusiness>();
      await masterData.init();

      for (final e in masterData.answers!) {
        if (StringUtils.isNotNullOrEmpty(e.imagePath)) {
          await precacheImage(AssetImage('assets/images/${e.imagePath!}'), context);
        }
      }
      // for (final e in ImagePath.allImage) {
      //   await precacheImage(AssetImage(e), context);
      // }

      // get reference data;
      final userRef = injector.get<UserReference>();
      statusQuiz = await userRef.getStatusQuiz() ?? StatusQuiz.inProgress;
      houseResult = await userRef.getHouseResult() ?? '';

      // CHEAT DATA FOR TESTING
      await userRef.setGryPoint(0);
      await userRef.setRavPoint(0);
      await userRef.setHufPoint(0);
      await userRef.setSlyPoint(0);
      await userRef.setCurrentQuestion(1);
      await userRef.setStatusQuiz(StatusQuiz.inProgress);
    } else {
      await openAppSettings();
      exit(0);
    }
  }

  Future<void> timeSplashScreen() async {
    await Future.wait(
      [_initializeDependencies(), Future.delayed(const Duration(seconds: 1))],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: timeSplashScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagePath.splash_screen),
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (statusQuiz == StatusQuiz.inProgress) {
                Navigator.pushReplacementNamed(context, ScreenName.home);
              } else {
                Navigator.pushReplacementNamed(context, ScreenName.result, arguments: houseResult);
              }
            });
            return Container();
          }
        });
  }
}
