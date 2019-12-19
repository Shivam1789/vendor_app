import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      getToast(msg: "${AppMessages.noInternetError}");
      return;
    }

    Map<String, dynamic> body = {
      "email": "${emailController.text}",
      "password": "${passwordController.text}"
    };

    try {
      var result =
          await ApiManager.login(header: {}, body: body, context: context);
      print("result :$result");
      String token = result != null ? "${result['token'] ?? ""}" : "";
      print("bloc Staus:$token");
      String msg = result != null ? result['message'] ?? "" : "";
      String name = result != null ? result['name'] ?? "" : "";
      print(msg);
      if (token.isNotEmpty) {
        await MemoryManagement.init();
        MemoryManagement.setAccessToken(accessToken: token);
        MemoryManagement.setName(name: name);
        _customLoader.hideLoader();
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => new HomeScreen()),
            (Route<dynamic> route) => false);
      }
    } catch (e, st) {
      _customLoader.hideLoader();
      print("Exception  login:: $e \n stacktrace $st");

      getToast(msg: "${AppMessages.generalError}");
    }
  }

  Widget getToast({String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }


  @override
  dispose() {
    return null;
  }
}
