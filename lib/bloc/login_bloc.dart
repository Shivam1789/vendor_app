import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vendor_flutter/NavigationDrawer/home.dart';
import 'package:vendor_flutter/Utils/Messages.dart';
import 'package:vendor_flutter/Utils/ReusableComponents/customLoader.dart';
import 'package:vendor_flutter/Utils/UniversalFunctions.dart';
import 'package:vendor_flutter/Utils/memory_management.dart';
import 'package:vendor_flutter/networks/api_manager.dart';

import 'bloc.dart';

class LoginBloc extends BaseBloc {
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  CustomLoader _customLoader = CustomLoader();

  //signIn method
  login(BuildContext context) async {
    _customLoader.showLoader(context);
    bool isConnected = await isConnectedToInternet();
    if (!isConnected ?? true) {
      _customLoader.hideLoader();
      showAlertDialog(
          context: context,
          title: "Error",
          message: AppMessages.noInternetError);
      return;
    }

    Map<String, dynamic> body = {
      "email": "${emailController.text}",
      "password": "${passwordController.text}"
    };

    try {
      var result =
          await ApiManager.login(header: {}, body: body, context: context);

      String token = "${result['token']}";
      print("bloc Staus:$token");

      if (token != null) {
        await MemoryManagement.init();
        MemoryManagement.setAccessToken(accessToken: token);
        _customLoader.hideLoader();
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => new HomeScreen()),
            (Route<dynamic> route) => false);
      } else {
        _customLoader.hideLoader();
        showAlertDialog(
            context: context, title: "Error", message: result['message']);
      }
    } catch (e, st) {
      _customLoader.hideLoader();
      print("Exception  login:: $e \n stacktrace $st");
      showAlertDialog(
          context: context,
          title: "Error",
          message: "${AppMessages.generalError}");
    }
  }

  @override
  dispose() {
    return null;
  }
}
