import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Splash/SplashScreen.dart';
import 'Utils/AppTheme.dart';

Future<void> main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData,
      home: SplashScreen(), //Dashboard(),
    ),
  );
}
