// todo: Plugins
//simple_permissions: ^0.1.9
//image_picker: ^0.6.0+3

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../UniversalFunctions.dart';

const String _cameraNotAuthorisedMessage =
    "App is not authorised to use camera.";
const String _galleryNotAuthorisedMessage =
    "App is not authorised to use gallery.";

// Checks target platform
bool isAndroid() {
  return defaultTargetPlatform == TargetPlatform.android;
}

// Can return image

Future checkPermissionAndOpenCamera(BuildContext context) async {
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
//    alreadyAskingPermission = true;
//    final res = await SimplePermissions.requestPermission(Permission.Camera);
//    print("res----->${res}");
//    alreadyAskingPermission = false;
//    if ((res == PermissionStatus.deniedNeverAsk && isAndroid()) ||
//        (res == PermissionStatus.denied && !isAndroid())) {
//      showSettingAlert(
//        context,
//        _cameraNotAuthorisedMessage,
//      );
//    } else {
//      if (res == PermissionStatus.denied) {
//        Navigator.of(
//          context,
//          rootNavigator: true,
//        ).pop(null);
//      } else {

    var cameraObj = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );

    Navigator.of(
      context,
      rootNavigator: true,
    ).pop(cameraObj);

    // }
  } on PlatformException {
//      platformVersion = 'Failed to get platform version.';
  } catch (e) {}
}

Future checkPermissionAndOpenGallery(BuildContext context) async {
  bool cameraPermission;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    alreadyAskingPermission = true;
    final res =
    // await SimplePermissions.requestPermission(Permission.PhotoLibrary);
    alreadyAskingPermission = false;
    print("res---->$res");

//    if ((res == PermissionStatus.deniedNeverAsk && isAndroid()) ||
//        (res == PermissionStatus.denied && !isAndroid())) {
//      showSettingAlert(
//        context,
//        _galleryNotAuthorisedMessage,
//      );
//    } else {
    var galleryObj = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    Navigator.of(
      context,
      rootNavigator: true,
    ).pop(galleryObj);
    // }
  } on PlatformException {
//      platformVersion = 'Failed to get platform version.';
  } catch (e) {}
}

showSettingAlert(BuildContext context, String message) {
  showAlert(
    context: context,
    titleText: "ERROR",
    message: message,
    actionCallbacks: {
      "Not now": () {},
      "Settings": () async {
        await Future.delayed(new Duration(
          milliseconds: 200,
        ));
        //SimplePermissions.openSettings();
      },
    },
  );
}

bool alreadyAskingPermission = false;

// Shows image picker
Future<File> showImagePicker({
  @required BuildContext context,
  int maxSizeInMB = 5,
}) async {
  File file = await showDialog<File>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new CupertinoAlertDialog(
          title: null,
          content: new Text(
            "CHOOSE OPTION",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                if (!alreadyAskingPermission) {
                  var result = await checkPermissionAndOpenCamera(context);
                }
              },
              child: Text('Camera'),
            ),
            FlatButton(
              onPressed: () async {
                if (!alreadyAskingPermission) {
                  var result = await checkPermissionAndOpenGallery(context);
                }
              },
              child: Text('Gallery'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "CANCEL",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      });
  if (file != null) {
    print("FILE: ${file.path}");
    print("FILE: ${file.lengthSync()}");

    // in bits (5mb)
    if (file.lengthSync() <= 4000000 * maxSizeInMB) {
      return file;
    } else {
      showAlert(
        context: context,
        titleText: "ERROR",
        message: "File size must not be greater than ${maxSizeInMB}MB.",
        actionCallbacks: {
          "OK": () {},
        },
      );
      return null;
    }
  }
  return null;
}

// todo: NATIVE PLUGIN FIXES
/*********************Change in class name SimplePermissionsPlugin.java************************/

//package com.ethras.simplepermissions;
//
//import android.Manifest;
//import android.app.Activity;
//import android.content.Intent;
//import android.content.pm.PackageManager;
//import android.net.Uri;
//import android.provider.Settings;
//import androidx.core.app.ActivityCompat;
//import androidx.core.content.ContextCompat;
//import android.util.Log;
//
//import io.flutter.plugin.common.MethodCall;
//import io.flutter.plugin.common.MethodChannel;
//import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
//import io.flutter.plugin.common.MethodChannel.Result;
//import io.flutter.plugin.common.PluginRegistry;
//import io.flutter.plugin.common.PluginRegistry.Registrar;
//
///**
// * SimplePermissionsPlugin
// */
//public class SimplePermissionsPlugin implements MethodCallHandler, PluginRegistry.RequestPermissionsResultListener {
//  private Registrar registrar;
//  private Result result;
//
//  private static String MOTION_SENSOR = "MOTION_SENSOR";
//
//  /**
//   * Plugin registration.
//   */
//  public static void registerWith(Registrar registrar) {
//    final MethodChannel channel = new MethodChannel(registrar.messenger(), "simple_permissions");
//    SimplePermissionsPlugin simplePermissionsPlugin = new SimplePermissionsPlugin(registrar);
//    channel.setMethodCallHandler(simplePermissionsPlugin);
//    registrar.addRequestPermissionsResultListener(simplePermissionsPlugin);
//  }
//
//  private SimplePermissionsPlugin(Registrar registrar) {
//    this.registrar = registrar;
//  }
//
//  @Override
//  public void onMethodCall(MethodCall call, Result result) {
//    String method = call.method;
//    String permission;
//    switch (method) {
//      case "getPlatformVersion":
//        result.success("Android " + android.os.Build.VERSION.RELEASE);
//        break;
//      case "getPermissionStatus":
//        permission = call.argument("permission");
//        if (MOTION_SENSOR.equalsIgnoreCase(permission)) {
//          result.success(3);
//          break;
//        }
//        int value = checkPermission(permission) ? 3 : 2;
//        result.success(value);
//        break;
//      case "checkPermission":
//        permission = call.argument("permission");
//        if (MOTION_SENSOR.equalsIgnoreCase(permission)) {
//          result.success(true);
//          break;
//        }
//        result.success(checkPermission(permission));
//        break;
//      case "requestPermission":
//        permission = call.argument("permission");
//        if (MOTION_SENSOR.equalsIgnoreCase(permission)) {
//          result.success(3);
//          break;
//        }
//        this.result = result;
//        requestPermission(permission);
//        break;
//      case "openSettings":
//        openSettings();
//        result.success(true);
//        break;
//      default:
//        result.notImplemented();
//        break;
//    }
//  }
//
//  private void openSettings() {
//    Activity activity = registrar.activity();
//    Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
//        Uri.parse("package:" + activity.getPackageName()));
//    intent.addCategory(Intent.CATEGORY_DEFAULT);
//    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//    activity.startActivity(intent);
//  }
//
//  private String getManifestPermission(String permission) {
//    String res;
//    switch (permission) {
//      case "RECORD_AUDIO":
//        res = Manifest.permission.RECORD_AUDIO;
//        break;
//      case "CALL_PHONE":
//        res = Manifest.permission.CALL_PHONE;
//        break;
//      case "CAMERA":
//        res = Manifest.permission.CAMERA;
//        break;
//      case "WRITE_EXTERNAL_STORAGE":
//        res = Manifest.permission.WRITE_EXTERNAL_STORAGE;
//        break;
//      case "READ_EXTERNAL_STORAGE":
//        res = Manifest.permission.READ_EXTERNAL_STORAGE;
//        break;
//      case "READ_PHONE_STATE":
//        res = Manifest.permission.READ_PHONE_STATE;
//        break;
//      case "ACCESS_FINE_LOCATION":
//        res = Manifest.permission.ACCESS_FINE_LOCATION;
//        break;
//      case "ACCESS_COARSE_LOCATION":
//        res = Manifest.permission.ACCESS_COARSE_LOCATION;
//        break;
//      case "WHEN_IN_USE_LOCATION":
//        res = Manifest.permission.ACCESS_FINE_LOCATION;
//        break;
//      case "ALWAYS_LOCATION":
//        res = Manifest.permission.ACCESS_FINE_LOCATION;
//        break;
//      case "READ_CONTACTS":
//        res = Manifest.permission.READ_CONTACTS;
//        break;
//      case "SEND_SMS":
//        res = Manifest.permission.SEND_SMS;
//        break;
//      case "READ_SMS":
//        res = Manifest.permission.READ_SMS;
//        break;
//      case "VIBRATE":
//        res = Manifest.permission.VIBRATE;
//        break;
//      case "WRITE_CONTACTS":
//        res = Manifest.permission.WRITE_CONTACTS;
//        break;
//      default:
//        res = "ERROR";
//        break;
//    }
//    return res;
//  }
//
//  private void requestPermission(String permission) {
//    Activity activity = registrar.activity();
//    permission = getManifestPermission(permission);
//    Log.i("SimplePermission", "Requesting permission : " + permission);
//    String[] perm = {permission};
//    ActivityCompat.requestPermissions(activity, perm, 0);
//  }
//
//  private boolean checkPermission(String permission) {
//    Activity activity = registrar.activity();
//    permission = getManifestPermission(permission);
//    Log.i("SimplePermission", "Checking permission : " + permission);
//    return PackageManager.PERMISSION_GRANTED == ContextCompat.checkSelfPermission(activity, permission);
//  }
//
//  @Override
//  public boolean onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
//  int status = 0;
//  Log.i("SimplePermission", "Checking permissions array : " + permissions[0]);
//  String permission = permissions[0];
//  if (requestCode == 0 && grantResults.length > 0 && !permission.equals("ERROR")) {
//  if (ActivityCompat.shouldShowRequestPermissionRationale(registrar.activity(), permission)) {
//  //denied
//  status = 2;
//  } else {
//  if (ActivityCompat.checkSelfPermission(registrar.context(), permission) == PackageManager.PERMISSION_GRANTED) {
//  //allowed
//  status = 3;
//  } else {
//  //set to never ask again
//  Log.e("SimplePermission", "set to never ask again" + permission);
//  status = 4;
//  }
//  }
//  }
//  Log.i("SimplePermission", "Requesting permission status : " + status);
//  Result result = this.result;
//  this.result = null;
//  if(result != null) {
//  result.success(status);
//  }
//  return status == 3;
//  }
//}

// // todo: USAGE EXAMPLE
// Returns profile pic field
//get _getProfilePicField {
//  final double imageWidth = getScreenSize(context: context).width * 0.45;
//  final double imageHeight = getScreenSize(context: context).width * 0.45;
//  return new Stack(
//    children: <Widget>[
//      // todo: uncomment
//      selectedImage == null
////          (CurrentUser.instance.data?.data?.profilePic == null)
//          ? new Container(
//        height: imageHeight,
//        width: imageWidth,
//        decoration: new BoxDecoration(
//          shape: BoxShape.circle,
//          border: new Border.all(
//            color: Colors.black,
//            width: 2,
//          ),
//        ),
//        child: new Icon(
//          Icons.person,
//        ),
//      )
//          : new ClipOval(
//        child: new Container(
//          height: imageHeight,
//          width: imageWidth,
//          color: Colors.white,
//          child: new Image.file(
//            selectedImage,
//          ),
////              child: getCachedNetworkImage(
////                url:
////                // todo: uncomment
////                _profilePicUrl
//////                CurrentUser.instance.data?.data?.profilePic
////                    ??
////                    "",
////                fit: BoxFit.cover,
////              ),
//        ),
//      ),
//      new Positioned(
//        bottom: imageHeight * 0.07,
//        right: imageWidth * 0.07,
//        child: new Material(
//          color: AppColors.kAppBlack,
//          shape: StadiumBorder(),
//          child: new InkWell(
//            onTap: () async {
//              File file =
//              await showImagePicker(context: context,maxSizeInMB: 5);
//              if (file != null) {
//                setState(() {
//                  selectedImage = file;
//                });
//              }
//            },
//            borderRadius: BorderRadius.circular(imageWidth * 0.05),
//            child: new Container(
//              padding: new EdgeInsets.all(imageHeight * 0.018),
//              child: new Icon(
//                Icons.edit,
//                color: Colors.white,
//                size: imageHeight * 0.13,
//              ),
//              decoration: new BoxDecoration(
//                shape: BoxShape.circle,
//                border: new Border.all(
//                  color: Colors.grey,
//                  width: 1,
//                ),
//              ),
//            ),
//          ),
//        ),
//      )
//    ],
//  );
//}