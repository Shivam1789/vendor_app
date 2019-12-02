import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'AppColors.dart';
import 'Localization.dart';
import 'LocalizationValues.dart';
import 'Messages.dart';
import 'ReusableComponents/CustomNavigationTranstions.dart';
import 'UniversalProperties.dart';
import 'memory_management.dart';

// Returns screen size
Size getScreenSize({@required BuildContext context}) {
  return MediaQuery.of(context).size;
}

// Returns status bar height
double getStatusBarHeight({@required BuildContext context}) {
  return MediaQuery.of(context).padding.top;
}

// Returns bottom padding for round edge screens
double getSafeAreaBottomPadding({@required BuildContext context}) {
  return MediaQuery.of(context).padding.bottom;
}

// Returns Keyboard size
double getKeyboardSize({@required BuildContext context}) {
  return MediaQuery.of(context).viewInsets.bottom;
}

// Show alert dialog
void showAlert(
    {@required BuildContext context,
    String titleText,
    Widget title,
    String message,
    Widget content,
    Map<String, VoidCallback> actionCallbacks}) {
  Widget titleWidget = titleText == null
      ? title
      : new Text(
          titleText.toUpperCase(),
          textAlign: TextAlign.center,
          style: new TextStyle(
            color: dialogContentColor,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        );
  Widget contentWidget = message == null
      ? content != null ? content : new Container()
      : new Text(
          message,
          textAlign: TextAlign.center,
          style: new TextStyle(
            color: dialogContentColor,
            fontWeight: FontWeight.w400,
//            fontFamily: Constants.contentFontFamily,
          ),
        );

  OverlayEntry alertDialog;
  // Returns alert actions
  List<Widget> _getAlertActions(Map<String, VoidCallback> actionCallbacks) {
    List<Widget> actions = [];
    actionCallbacks.forEach((String title, VoidCallback action) {
      actions.add(
        new ButtonTheme(
          minWidth: 0.0,
          child: new CupertinoDialogAction(
            child: new Text(title,
                style: new TextStyle(
                  color: dialogContentColor,
                  fontSize: 16.0,
//                        fontFamily: Constants.contentFontFamily,
                )),
            onPressed: () {
              action();
              alertDialog?.remove();
              alertAlreadyActive = false;
            },
          ),
//          child: defaultTargetPlatform != TargetPlatform.iOS
//              ? new FlatButton(
//                  child: new Text(
//                    title,
//                    style: new TextStyle(
//                      color: ProPawnColors.kPrimaryBlue,
////                      fontFamily: Constants.contentFontFamily,
//                    ),
//                    maxLines: 2,
//                  ),
//                  onPressed: () {
//                    action();
//                  },
//                )
//              :
// new CupertinoDialogAction(
//                  child: new Text(title,
//                      style: new TextStyle(
//                        color: ProPawnColors.kPrimaryBlue,
//                        fontSize: 16.0,
////                        fontFamily: Constants.contentFontFamily,
//                      )),
//                  onPressed: () {
//                    action();
//                  },
//                ),
        ),
      );
    });
    return actions;
  }

  List<Widget> actions =
      actionCallbacks != null ? _getAlertActions(actionCallbacks) : [];

  OverlayState overlayState;
  overlayState = Overlay.of(context);

  alertDialog = new OverlayEntry(builder: (BuildContext context) {
    return new Positioned.fill(
      child: new Container(
        color: Colors.black.withOpacity(0.7),
        alignment: Alignment.center,
        child: new WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: new Dialog(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            child: new Material(
              borderRadius: new BorderRadius.circular(10.0),
              color: AppColors.kWhite,
              child: new Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                            ),
                            child: titleWidget,
                          ),
                          contentWidget,
                        ],
                      ),
                    ),
                    new Container(
                      height: 0.6,
                      margin: new EdgeInsets.only(
                        top: 24.0,
                      ),
                      color: dialogContentColor,
                    ),
                    new Row(
                      children: <Widget>[]..addAll(
                          new List.generate(
                            actions.length +
                                (actions.length > 1 ? (actions.length - 1) : 0),
                            (int index) {
                              return index.isOdd
                                  ? new Container(
                                      width: 0.6,
                                      height: 30.0,
                                      color: dialogContentColor,
                                    )
                                  : new Expanded(
                                      child: actions[index ~/ 2],
                                    );
                            },
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  });

  if (!alertAlreadyActive) {
    alertAlreadyActive = true;
    overlayState.insert(alertDialog);
  }
}

// Checks Internet connection for "POST" method
Future<void> checkInternetForPostMethod(
    {@required BuildContext context,
    @required bool mounted,
    @required Function onSuccess,
    @required Function onFail,
    bool canShowAlert = true}) async {
  try {
    final result = await InternetAddress.lookup('google.com')
        .timeout(const Duration(seconds: 5));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      onSuccess();
    } else {
      onFail();
      if (canShowAlert) {
        showAlert(
            context: context,
            titleText: Localization.of(context).trans(LocalizationValues.error),
            message: AppMessages.noInternetError,
            actionCallbacks: {
              Localization.of(context).trans(LocalizationValues.ok): () {}
            });
      }
    }
  } catch (_) {
    onFail();
    showAlert(
        context: context,
        titleText: Localization.of(context).trans(LocalizationValues.error),
        message: AppMessages.noInternetError,
        actionCallbacks: {
          Localization.of(context).trans(LocalizationValues.ok): () {}
        });
  }
}

// Closes keyboard by clicking any where on screen
void closeKeyboard({
  @required BuildContext context,
  @required VoidCallback onClose,
}) {
  if (getKeyboardSize(context: context) > 0.0) {
    FocusScope.of(context).requestFocus(new FocusNode());
    try {
      onClose();
    } catch (e) {}
  }
}

// Closes keyboard by clicking any where on screen
bool isKeyboardOpen({
  @required BuildContext context,
}) {
  print("keybaord open---->${getKeyboardSize(context: context)}");
  return getKeyboardSize(context: context) > 0.0;
}

// Checks Internet connection
Future<bool> hasInternetConnection({
  @required BuildContext context,
  bool mounted,
  @required Function onSuccess,
  @required Function onFail,
  bool canShowAlert = true,
}) async {
  try {
    final result = await InternetAddress.lookup('google.com')
        .timeout(const Duration(seconds: 5));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      onSuccess();
      return true;
    } else {
      if (canShowAlert) {
        onFail();
        showAlert(
          context: context,
          titleText: Localization.of(context).trans(LocalizationValues.error),
          message: AppMessages.noInternetError,
          actionCallbacks: {
            Localization.of(context).trans(LocalizationValues.ok): () {
              return false;
            }
          },
        );
      }
    }
  } catch (_) {
    onFail();
    showAlert(
        context: context,
        titleText: Localization.of(context).trans(LocalizationValues.error),
        message: AppMessages.noInternetError,
        actionCallbacks: {
          Localization.of(context).trans(LocalizationValues.ok): () {
            return false;
          }
        });
  }
  return false;
}

// Sets focus node
void setFocusNode({
  @required BuildContext context,
  @required FocusNode focusNode,
}) {
  FocusScope.of(context).requestFocus(focusNode);
}

// Returns formatted date string
String getFormattedDateString({
  String format,
  @required DateTime dateTime,
}) {
  return dateTime != null
      ? new DateFormat(format ?? "MMM dd, y").format(dateTime)
      : "-";
}

/// 1) Parses string to date
/// 2) Returns formatted date string
String parseGetFormattedDateString({
  String format,
  @required String dateString,
}) {
  try {
    return new DateFormat(format ?? "MMM dd, y")
        .format(DateTime.parse(dateString).toLocal());
  } catch (e) {
    return "-";
  }
}

// Returns datetime parsing string of format "MM/dd/yy"
DateTime getDateFromString({
  @required String dateString,
}) {
  try {
    return DateTime.parse(dateString);
  } catch (e) {
    return DateTime.now();
  }
}

// CONVERTS DOUBLE INTO RADIANS
num getRadians({@required double value}) {
  return value * (3.14 / 180);
}

//logout(context) async {
//  print("logged out");
//  await MemoryManagement.clearMemory();
//  await Navigator.pushAndRemoveUntil(
//      //await is required as bloc calling this method need not to return anything
//      context,
//      MaterialPageRoute(builder: (context) => LoginScreen()),
//      (context) => false);
//}

// Checks target platform
bool isAndroid() {
  return defaultTargetPlatform == TargetPlatform.android;
}

// Can return image

//Future checkPermissionAndOpenCamera(BuildContext context) async {
//  // Platform messages may fail, so we use a try/catch PlatformException.
//  try {
//    alreadyAskingPermission = true;
//    final res = await SimplePermissions.requestPermission(Permission.Camera);
//    print("res----->${res}");
//    alreadyAskingPermission = false;
//    if ((res == PermissionStatus.deniedNeverAsk && isAndroid()) ||
//        (res == PermissionStatus.denied && !isAndroid())) {
//      print("inside");
//
//      await showSettingAlert(context, AppMessages.routeToSetting);
//    } else {
//      if (res == PermissionStatus.denied) {
//        print("Permission Denied ");
//        Navigator.of(
//          context,
//          rootNavigator: true,
//        ).pop(null);
//      } else {
//        print(" Else denide");
//        var cameraObj = await ImagePicker.pickImage(
//          source: ImageSource.camera,
//        );
//
//        Navigator.of(
//          context,
//          rootNavigator: true,
//        ).pop(cameraObj);
//      }
//    }
//  } on PlatformException {
////      platformVersion = 'Failed to get platform version.';
//  } catch (e) {}
//}

//Future checkPermissionAndOpenGallery(BuildContext context) async {
//  bool cameraPermission;
//  // Platform messages may fail, so we use a try/catch PlatformException.
//  try {
//    alreadyAskingPermission = true;
//    final res =
//        await SimplePermissions.requestPermission(Permission.PhotoLibrary);
//    alreadyAskingPermission = false;
//    print("res---->$res");
//
//    if ((res == PermissionStatus.deniedNeverAsk && isAndroid()) ||
//        (res == PermissionStatus.denied && !isAndroid())) {
//      showSettingAlert(context, "dfasdfd");
//    } else {
//      var galleryObj = await ImagePicker.pickImage(
//        source: ImageSource.gallery,
//      );
//      Navigator.of(
//        context,
//        rootNavigator: true,
//      ).pop(galleryObj);
//    }
//  } on PlatformException {
////      platformVersion = 'Failed to get platform version.';
//  } catch (e) {}
//}

showSettingAlert(BuildContext context, String message) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Alert"),
          content: Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(message ?? ""),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("Settings"),
              onPressed: () async {
                await Future.delayed(new Duration(
                  milliseconds: 200,
                ));
                //SimplePermissions.openSettings();
              },
            ),
            CupertinoDialogAction(
              child: Text("Ok"),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}

bool alreadyAskingPermission = false;

Future<File> showMediaAlert({@required BuildContext context}) async {
  File file = await showDialog<File>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new CupertinoAlertDialog(
          title: null,
          content: new Text(
            Localization.of(context).trans(LocalizationValues.chooseOption),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                if (!alreadyAskingPermission) {
                  //var result = await checkPermissionAndOpenCamera(context);
                }
              },
              child: Text('Camera'),
            ),
            FlatButton(
              onPressed: () async {
                if (!alreadyAskingPermission) {
                 // var result = await checkPermissionAndOpenGallery(context);
                }
              },
              child: Text('Gallery'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                Localization.of(context).trans(LocalizationValues.cancel),
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      });
  return file;
}

// Asks for exit
Future<bool> askForExit() async {
  if (canExitApp) {
    exit(0);
    return Future.value(true);
  } else {
    canExitApp = true;
    Fluttertoast.showToast(
      msg: "Please click BACK again to exit",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
    new Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
      canExitApp = false;
    });
    return Future.value(false);
  }
}

// Returns no data view
Widget getNoDataView({
  @required String msg,
  @required BuildContext context,
  TextStyle messageTextStyle,
  @required VoidCallback onRetry,
}) {
  return new Center(
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(
          msg,
          style: messageTextStyle ??
              const TextStyle(
                fontSize: 18.0,
              ),
        ),
        new InkWell(
          onTap: onRetry ?? () {},
          child: new Text(
            Localization.of(context).trans(LocalizationValues.refresh),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

// Returns platform specific back button icon
IconData getPlatformSpecificBackIcon() {
  return defaultTargetPlatform == TargetPlatform.iOS
      ? Icons.arrow_back_ios
      : Icons.arrow_back;
}

// Custom pop Until Dashboard
void customPopUntilDashboard({
  @required BuildContext context,
}) {
  Navigator.popUntil(
    context,
    (route) {
      return route.runtimeType == DashboardPageRoute;
    },
  );
}

// Returns first letter capitalized of the string
String getFirstLetterCapitalized({@required String source}) {
  if (source == null) {
    return "";
  } else {
    String result = source.toUpperCase().substring(0, 1);
    if (source.length > 1) {
      result = result + source.toLowerCase().substring(1, source.length);
    }
    return result;
  }
}

// Sets tab Count
String setTabCount({@required int count}) {
  return count == null
      ? ""
      : count > 0 ? count > 99 ? "(99+)" : "($count)" : "";
}

////
showAlertDialog({context, title, message, iconData}) {
  return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: iconData == null ? Text("$title") : Icon(iconData),
          content: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text("$message"),
          ),
          actions: <Widget>[
            CupertinoButton(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Text(
                "Ok",
                style: TextStyle(color: AppColors.kGreen),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}

showOptionDialog({context, title, message, iconData,trueButtonTitle:"ok",falseButtonTitle:"cancel"}) {
  return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: iconData == null ? Text("$title") : Icon(iconData),
          content: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text("$message"),
          ),
          actions: <Widget>[
            CupertinoButton(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Text(
                trueButtonTitle,
                style: TextStyle(color: AppColors.kGreen),
              ),
              onPressed: () {
                Navigator.pop(context,true);
              },
            ),
            CupertinoButton(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Text(
                falseButtonTitle,
                style: TextStyle(color: AppColors.kGreen),
              ),
              onPressed: () {
                Navigator.pop(context,false);
              },
            )
          ],
        );
      });
}

//Check for internet Connection

Future<bool> isConnectedToInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com')
        .timeout(const Duration(seconds: 5));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } catch (_) {
    return false;
  }
}

//Future<bool> isCameraAccessAllowed() async {
//  final res = await SimplePermissions.checkPermission(Permission.Camera);
//
//  print("res$res");
//  if (res ?? false) {
//    return true;
//  } else {
//    return false;
//  }
//}

//askCameraPermission(BuildContext context, {isFirst: false}) async {
//  try {
//    alreadyAskingPermission = true;
//    final res = await SimplePermissions.requestPermission(Permission.Camera);
//    final aud =
//        await SimplePermissions.requestPermission(Permission.RecordAudio);
//    print("res----->${res}");
//    alreadyAskingPermission = false;
//
//    if (isFirst) {
//      // if first time no need to show setting pop up
//      return;
//    }
//
//    if ((res == PermissionStatus.deniedNeverAsk && isAndroid()) ||
//        (res == PermissionStatus.denied && !isAndroid())) {
//      print("inside");
//      await showSettingAlert(context, AppMessages.routeToSetting);
//    } else {}
//  } on PlatformException {
////      platformVersion = 'Failed to get platform version.';
//  } catch (e) {}
//}

String toMsgTimeFormat(DateTime dateTime) {
  return dateTime == null ? "" : DateFormat.jm().format(dateTime);
}
String toChatDateFormat(DateTime dateTime) {
  return dateTime == null ? "" : DateFormat("EEEE, MMM d y").format(dateTime);
}
