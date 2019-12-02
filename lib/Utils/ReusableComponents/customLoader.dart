import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../AppColors.dart';
import '../UniversalFunctions.dart';
import 'floader.dart';

class CustomLoader {
  static CustomLoader _customLoader;

  CustomLoader._createObject();

  factory CustomLoader() {
    if (_customLoader != null) {
      return _customLoader;
    } else {
      _customLoader = CustomLoader._createObject();
      return _customLoader;
    }
  }

  //static OverlayEntry _overlayEntry;
  OverlayState _overlayState; //= new OverlayState();
  OverlayEntry _overlayEntry;

  _buildLoader() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Container(
            height: getScreenSize(context: context).height,
            width: getScreenSize(context: context).width,
            child: buildLoader());
      },
    );
  }

  showLoader(context) {
    _overlayState = Overlay.of(context);
    _buildLoader();
    _overlayState.insert(_overlayEntry);
  }

  hideLoader() {
    try {
      print("hide Loader called ");
      _overlayEntry?.remove();
      _overlayEntry = null;
    } catch (e) {
      print("Exception:: $e");
    }
  }

  buildLoader({isTransparent: false}) {
    return Container(
      child: Center(
        child: Container(
          color: isTransparent
              ? Colors.transparent
              : Colors.black.withOpacity(0.7),
          child: Center(
              child: SpinKitFadingCircle(
            color: AppColors.kGreen,
          )

//            child: CupertinoActivityIndicator(
//
//              radius: 20,
//            ),
              ), //CircularProgressIndicator(),
        ),
      ),
    );
  }
}
