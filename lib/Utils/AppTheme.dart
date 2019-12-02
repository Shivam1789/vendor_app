import 'package:flutter/material.dart';

import 'AppColors.dart';
import 'AssetStrings.dart';
import 'UniversalProperties.dart';


/// PRIMARY COLORS
Color _appPrimaryColor = AppColors.kGreen;
Color _appPrimaryLightColor = AppColors.kGreen;
Color _appPrimaryDarkColor = AppColors.kGreen;

/// ADDITIONAL PRIMARY COLORS
const appBarBackgroundColor = AppColors.kAppBlack;
const appCustomButtonTitleColor = Colors.deepOrange;
const appCustomResponseAlertIconColor = Colors.deepOrange;

/// SECONDARY COLORS
Color _appSecondaryColor =
    AppColors.kGreen; // USUALLY KEPT SAME AS PRIMARY COLOR
Color _appSecondaryLightColor = AppColors.kGreen;
Color _appSecondaryDarkColor = AppColors.kGreen;

/// SHEET COLORS
const _appCanvasColor = Colors.white;
final _appBackgroundColor = Colors.white;
const _appScaffoldBackgroundColor = AppColors.kScaffoldBG;
const _appDialogBackgroundColor = Colors.white;

// Heading title font
const appHeadingTitleFont = AssetStrings.PoppinsFont;
const double appHeadingTitleSpacing = 1.0;
const double _appTextLetterSpacing = 0.5;

/// GOOD DEFAULTS
//const _appUnselectedWidgetColor = Colors.grey; // USUALLY KEPT AS DEFAULTS
//const _appDisabledColor = Colors.grey;  // USUALLY KEPT AS DEFAULTS
//const _appBottomAppBarColor = Colors.lime; // USUALLY KEPT AS DEFAULTS
//const _appCardColor = Colors.cyanAccent; // USUALLY KEPT AS DEFAULTS
//const _appHighLightColor = const Color(0xFFfce4ec); // USUALLY KEPT AS DEFAULTS
//const _appSplashColor = const Color(0xFF004d40); // USUALLY KEPT AS DEFAULTS
//const _appDividerColor = const Color(0xFF6746c3); // USUALLY KEPT AS DEFAULTS
Color _appToggleableActiveColor = AppColors.kGreen;

/// BETTER CUSTOMIZED
Color _appButtonColor = AppColors.kGreen;
Color _appHighLightColor = AppColors.kGreen;
Color _appIndicatorColor = AppColors.kWhite;

/// USED IN "DataTable"
Color _appSelectedRowColor = const Color(0xFF4e342e);
Color _appSecondaryHeaderColor = const Color(0xFFbf360c);

/// "TEXT FIELD PROPERTIES"
Color _appTextSelectionColor = AppColors.kGreen;
Color _appTextSelectionHandleColor = AppColors.kGreen;
Color _appHintColor = Colors.grey;
Color _appErrorColor = Colors.red;


// Appbar theme
const AppBarTheme _appBarTheme = const AppBarTheme(
  color: appBarBackgroundColor,
  textTheme: const TextTheme(
//
    title: appBarTitleTextStyle,
//
    /// CHILD TEXT
    body1: const TextStyle(
      color: Colors.white,
      fontSize: 15.0,
      fontFamily: AssetStrings.PoppinsFont,
      letterSpacing: _appTextLetterSpacing,
    ),
//
//  /// HELPER WIDGET TEXT ( EG: TITLE OF CHIP, TITLE OF STEP)
    body2: const TextStyle(
      color: Colors.white,
      fontFamily: AssetStrings.PoppinsFont,
      letterSpacing: _appTextLetterSpacing,
    ),
//
//  /// BUTTON CHILD TEXT
    button: const TextStyle(
      fontSize: 15.0,
      color: Colors.black,
      fontFamily: AssetStrings.PoppinsFont,
      letterSpacing: _appTextLetterSpacing,
    ),
//
//  /// HELPER TEXT
    caption: const TextStyle(fontSize: 14.0, color: AppColors.kGreen),
//
    display1: const TextStyle(fontSize: 50.0, color: Colors.orange),
    display2: const TextStyle(fontSize: 50.0, color: Colors.orange),
    display3: const TextStyle(fontSize: 50.0, color: Colors.orange),
    display4: const TextStyle(fontSize: 50.0, color: Colors.orange),
    headline: const TextStyle(fontSize: 50.0, color: Colors.orange),
//
//  /// EG. (DATE IN DATE PICKER, TextField INPUT TEXT)
    subhead: const TextStyle(
      fontSize: 15.0,
      color: Colors.white,
      fontFamily: AssetStrings.PoppinsFont,
      letterSpacing: _appTextLetterSpacing,
    ),
  ),
);

/// APPLICABLE ONLY WHEN TextField IS FOCUSED (ACTIVE)
InputDecorationTheme _appInputDecorationTheme = new InputDecorationTheme(
  hintStyle: new TextStyle(color: AppColors.kGreen),
  helperStyle: new TextStyle(color: AppColors.kGreen),
  isCollapsed: false,
  border: new UnderlineInputBorder(),
  isDense: true,
);

///// APPLIES TO ALL ICONS (UNLESS CONSTRAINED BY PARENT WIDGET)
const _appIconTheme = const IconThemeData(
  color: AppColors.kGreen,
  opacity: 1.0,
);
//

/// APPLIES TO ALL PRIMARY ICONS (ICONS INSIDE PRIMARY WIDGETS)  (UNLESS CONSTRAINED BY PARENT WIDGET)
const _appPrimaryIconTheme = const IconThemeData(color: Colors.white);

///// APPLIES TO SECONDARY ICONS (SIZE PROPERTY OVERRIDDEN FROM ICON THEME)
//const _appAccentIconTheme =
//const IconThemeData(color: Colors.yellow, size: 10.0, opacity: 1.0);
//

/// APPLIES TO ALL TEXT (UNLESS CONSTRAINED BY PARENT WIDGET)
const _appTextTheme = const TextTheme(
//
//  title: const TextStyle(color: Colors.green, fontSize: 5.0),
//
  /// CHILD TEXT
  body1: const TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    fontFamily: AssetStrings.PoppinsFont,
    letterSpacing: _appTextLetterSpacing,
  ),
//
//  /// HELPER WIDGET TEXT ( EG: TITLE OF CHIP, TITLE OF STEP)
  body2: const TextStyle(
    fontFamily: AssetStrings.PoppinsFont,
    letterSpacing: _appTextLetterSpacing,
  ),
//
//  /// BUTTON CHILD TEXT
  button: const TextStyle(
    fontSize: 15.0,
    color: Colors.black,
    fontFamily: AssetStrings.PoppinsFont,
    letterSpacing: _appTextLetterSpacing,
  ),
//
//  /// HELPER TEXT
//  caption: const TextStyle(fontSize: 14.0, color: Colors.blue),
//
//  display1: const TextStyle(fontSize: 50.0, color: Colors.orange),
//  display2: const TextStyle(fontSize: 50.0, color: Colors.orange),
//  display3: const TextStyle(fontSize: 50.0, color: Colors.orange),
//  display4: const TextStyle(fontSize: 50.0, color: Colors.orange),
//  headline: const TextStyle(fontSize: 50.0, color: Colors.orange),
//
//  /// EG. (DATE IN DATE PICKER, TextField INPUT TEXT)
  subhead: const TextStyle(
    fontSize: 15.0,
    color: Colors.black,
    fontFamily: AssetStrings.PoppinsFont,
    letterSpacing: _appTextLetterSpacing,
  ),
);

/// APPLIES TO ALL PRIMARY TEXT (TEXT INSIDE PRIMARY WIDGETS)  (UNLESS CONSTRAINED BY PARENT WIDGET)
const _appPrimaryTextTheme = const TextTheme(
  title: const TextStyle(
    fontFamily: AssetStrings.PoppinsFont,
    letterSpacing: _appTextLetterSpacing,
  ),
);


final ThemeData AppThemeData = new ThemeData(
  brightness: Brightness.light,
  primaryColor: _appPrimaryColor,
  primaryColorLight: _appPrimaryLightColor,
  primaryColorDark: _appPrimaryDarkColor,
  accentColor: _appSecondaryColor,
  backgroundColor: _appBackgroundColor,
  canvasColor: _appCanvasColor,
  scaffoldBackgroundColor: _appScaffoldBackgroundColor,
  dialogBackgroundColor: _appDialogBackgroundColor,
  cursorColor: AppColors.kGreen,
  appBarTheme: _appBarTheme,
  /// TODO: USE IN SPECIAL CASES (UNCOMMENT)
//  unselectedWidgetColor: _appUnselectedWidgetColor,
//  disabledColor: _appDisabledColor,
//  bottomAppBarColor: _appBottomAppBarColor,
//  cardColor: _appCardColor,
  highlightColor: _appHighLightColor,
//  splashColor: _appSplashColor,
//  dividerColor: _appDividerColor,
  buttonColor: _appButtonColor,
  toggleableActiveColor: _appToggleableActiveColor,

  /// TODO: USED IN "DATATABLE"
//  selectedRowColor: _appSelectedRowColor,
//  secondaryHeaderColor: _appSecondaryHeaderColor,

  /// "TEXT FIELD PROPERTIES"
  textSelectionColor: _appTextSelectionColor,
  textSelectionHandleColor: _appTextSelectionHandleColor,
  indicatorColor: _appIndicatorColor,
  hintColor: _appHintColor,
  errorColor: _appErrorColor,
//  inputDecorationTheme: _appInputDecorationTheme,
  iconTheme: _appIconTheme,
  primaryIconTheme: _appPrimaryIconTheme,
//    accentIconTheme: _appAccentIconTheme,
  textTheme: _appTextTheme,
  primaryTextTheme: _appPrimaryTextTheme,
);
