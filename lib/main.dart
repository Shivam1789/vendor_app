import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendor_flutter/Utils/AppColors.dart';
import 'package:vendor_flutter/jerryNest/ForgotPassword.dart';
import 'package:vendor_flutter/jerryNest/SignUpScreen.dart';
import 'Splash/SplashScreen.dart';
import 'Utils/AppTheme.dart';
import 'jerryNest/LoginScreen.dart';

Future<void> main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppColors.kGreen));

  runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData,
      home: SplashScreen(), //Dashboard(),
    ),
  );
}
