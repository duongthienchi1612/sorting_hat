import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sorting_hat/business/master_data_business.dart';
import 'package:sorting_hat/dependencies.dart';
import 'package:sorting_hat/utilities/database_factory.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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

      await injector.get<MasterDataBusiness>().init();
    } else {
      await openAppSettings();
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeDependencies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.purple,
            );
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/home');
            });
            return Container();
          }
        });
  }
}
