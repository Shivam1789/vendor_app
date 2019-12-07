import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unique_id/unique_id.dart';
import 'package:vendor_flutter/LogIn/sliding_login.dart';
import 'package:vendor_flutter/NavigationDrawer/home.dart';
import 'package:vendor_flutter/Utils/AssetStrings.dart';
import 'package:vendor_flutter/Utils/ReusableWidgets.dart';
import 'package:vendor_flutter/Utils/UniversalFunctions.dart';
import 'package:vendor_flutter/Utils/memory_management.dart';

// App started for the first time
bool _appInitiated = false;

class SplashScreen extends StatefulWidget {
  final Uri deepLink;

  const SplashScreen({Key key, this.deepLink}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Controllers
  AnimationController _resizableController;

  // UI properties
  bool isUserLoggedIn;
  bool splashLogoStage = false;

  // Returns logo
  Widget get _getLogoImage {
    return new SizedBox.expand(
      child: Image.asset(
        AssetStrings.splashImage3,
        fit: BoxFit.fill,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _setDefaults();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  //MARK:- Get device ID.
  void getDeviceId() async {
    try {
      var uniqueID = await UniqueId.getID;
      MemoryManagement.setDeviceId(deviceID: uniqueID);
      print("device_id------>$uniqueID");
    } on PlatformException {} catch (error) {
      print("Error----->$error");
    }
  }

  // Builds screen
  @override
  Widget build(BuildContext context) {
//    getLocale(context);
    return new WillPopScope(
      onWillPop: askForExit,
      child: new Stack(
        children: <Widget>[
          getAppThemedBGOne(),
          new Scaffold(
            backgroundColor: Colors.white,
            body: new Offstage(
              offstage: _appInitiated,
              child: new Center(
                child: _getLogoImage,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Methods

  // Sets properties to defaults
  void _setDefaults() async {
    _resizableController = new AnimationController(
      vsync: this,
      duration: new Duration(
        milliseconds: 700,
      ),
    );
    _resizableController.addStatusListener((animationStatus) {
      switch (animationStatus) {
        case AnimationStatus.completed:
          _resizableController.reverse();
          break;
        case AnimationStatus.dismissed:
          _resizableController.forward();
          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
      }
    });
    _resizableController.forward();
    bool sharedPrefsInitialized = await MemoryManagement.init();
    startTime();
  }

  /// 1) Accesses Shared preferences
  /// 2) Navigates to "Login" screen
  /// 3) Navigates to "Home" screen
  startTime() async {
    var _duration = new Duration(seconds: 5);

    return new Timer(_duration, () async {
      _appInitiated = true;
      setState(() {});
      _goToLoginScreen();
    });
  }

  // Disposes controllers
  _dispose() {
    _resizableController.dispose();
  }

  _goToLoginScreen() async {
    String token = MemoryManagement.getAccessToken();
    print("token : $token");
    if ((token?.trim() ?? "") == "") {
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => new LoginScreen()),
          (Route<dynamic> route) => false);
    } else {
      //await loadUser();
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => new HomeScreen()),
          (Route<dynamic> route) => false);
    }
  }

}
