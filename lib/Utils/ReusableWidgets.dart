import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'AppColors.dart';
import 'AssetStrings.dart';
import 'Clippers.dart';
import 'Localization.dart';
import 'LocalizationValues.dart';
import 'ReusableComponents/CheckBoxListPopUpMenu.dart';
import 'UniversalFunctions.dart';
import 'UniversalProperties.dart';

// Returns app themed background one
Widget getAppThemedBGOne() {
  return Positioned.fill(
      child: new Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xff8111b5)]),
    ),
  ));
}

// Returns back button
Widget getBackButton(BuildContext context, bool isWhite) {
  return new Align(
    alignment: Alignment.centerLeft,
    child: new InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: new Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        child: new Image.asset(
          isWhite ?? false
              ? AssetStrings.backIconWhite
              : AssetStrings.backIconGrey,
          scale: 3.5,
        ),
      ),
    ),
  );
}

// Returns "App themed text field" centered label
Widget appThemedTextFieldOne({
  @required String label,
  @required TextEditingController controller,
  @required BuildContext context,
  bool obscureText,
  @required FocusNode focusNode,
  TextInputType keyboardType,
  Function(String) validator,
  List<TextInputFormatter> inputFormatters,
  Function(String) onFieldSubmitted,
  int maxLength,
  int maxLines,
  bool enabled,
  TextStyle textStyle,
  TextStyle labelStyle,
  Color borderColor,
  String suffixAsset,
  Widget suffixSecondaryAsset,
  Widget prefixOneAsset,
  Function onPrefixOneTap,
  Widget prefixTwoAsset,
  Function onPrefixTwoTap,
  TextInputAction inputAction,
  TextCapitalization textCapitalization,
}) {
  // Defaults
  const TextStyle defaultLabelStyle = const TextStyle(
    color: Colors.white,
  );

  const TextStyle defaultTextStyle = const TextStyle(
    color: Colors.white,
  );

  const Color defaultBorderColor = Colors.white;

  return new Stack(
    children: <Widget>[
      new Column(
        children: <Widget>[
          new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              suffixAsset != null
                  ? new Container(
                      width: getScreenSize(context: context).width * 0.105,
                      height: getScreenSize(context: context).width * 0.1,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(
                        bottom: 6.0,
                        left: 8.0,
                      ),
                      child: new Image.asset(
                        suffixAsset,
                        width: getScreenSize(context: context).width * 0.04,
                        height: getScreenSize(context: context).width * 0.05,
                        fit: BoxFit.fill,
                      ),
                    )
                  : new Container(),
              new Container(
                height: getScreenSize(context: context).width * 0.074,
                child: suffixSecondaryAsset ?? new Container(),
              ),
              new Offstage(
                offstage: suffixSecondaryAsset == null,
                child: getSpacer(
                  width: 4.0,
                ),
              ),
              new Expanded(
                child: new Container(
                  child: new InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(focusNode);
                    },
                    child: new TextFormField(
                      textCapitalization:
                          textCapitalization ?? TextCapitalization.none,
                      textInputAction: inputAction ?? TextInputAction.next,
                      controller: controller,
                      obscureText: obscureText ?? false,
                      focusNode: focusNode,
                      keyboardType: keyboardType,
                      validator: validator,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(maxLength ?? 1000),
                      ]..addAll(inputFormatters ?? []),
                      onFieldSubmitted: onFieldSubmitted,
                      enabled: enabled,
                      maxLines: maxLines == 3 ? null : 1,
                      style: textStyle ?? defaultTextStyle,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                          top: 0.0,
                          bottom: 0.0,
                        ),
                        labelText: label,
                        labelStyle: labelStyle ?? defaultLabelStyle,
                        errorStyle: new TextStyle(
                          fontSize: 10.0,
                          color: labelStyle?.color ?? defaultLabelStyle?.color,
                        ),
                        helperStyle: new TextStyle(
                          fontSize: 0.0,
                        ),
                        isDense: true,
                      ),
                    ),
                  ),
                ),
              ),
              new Offstage(
                offstage: prefixOneAsset == null,
                child: new InkWell(
                  onTap: onPrefixOneTap,
                  child: new Container(
                    width: getScreenSize(context: context).width * 0.105,
                    height: getScreenSize(context: context).width * 0.1,
                    padding: const EdgeInsets.only(
                      bottom: 6.0,
                      right: 8.0,
                    ),
                    child: prefixOneAsset == null
                        ? new Container()
                        : new Container(
                            child: prefixOneAsset,
                            width: getScreenSize(context: context).width * 0.04,
                            height:
                                getScreenSize(context: context).width * 0.05,
                          ),
                  ),
                ),
              ),
              new Offstage(
                offstage: prefixTwoAsset == null,
                child: new InkWell(
                  onTap: onPrefixTwoTap,
                  child: new Container(
//                  color: Colors.amber,
                    width: getScreenSize(context: context).width * 0.07,
                    height: getScreenSize(context: context).width * 0.1,
                    padding: const EdgeInsets.only(
                      bottom: 6.0,
                      right: 8.0,
                    ),
                    child: prefixTwoAsset == null
                        ? new Container()
                        : new Container(
                            child: prefixTwoAsset,
                            width: getScreenSize(context: context).width * 0.04,
                            height:
                                getScreenSize(context: context).width * 0.05,
                          ),
                  ),
                ),
              ),
            ],
          ),
          getSpacer(
            height: 4.0,
          ),
          new Container(
            height: 1.0,
            color: borderColor ?? defaultBorderColor,
          ),
        ],
      ),
      new Positioned.fill(
        child: new Offstage(
          offstage: enabled ?? true,
          child: new Container(
            color: Colors.cyanAccent.withOpacity(0.0),
          ),
        ),
      ),
    ],
  );
}

// Returns "App themed Phone text field " centered label
Widget appThemedPhoneTextFieldOne({
  @required String label,
  @required Country initialSelectedCountry,
  @required TextEditingController controller,
  @required BuildContext context,
  @required Function(Country) onCountrySelected,
  bool obscureText,
  @required FocusNode focusNode,
  TextInputType keyboardType,
  Function(String) validator,
  List<TextInputFormatter> inputFormatters,
  Function(String) onFieldSubmitted,
  bool enabled,
  TextStyle textStyle,
  TextStyle labelStyle,
  Color borderColor,
  int maxLength,
  String suffixAsset,
  Widget prefixAsset,
  Function onPrefixTap,
  TextInputAction inputAction,
}) {
  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Text("+${country.phoneCode}"),
          SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      );

  void _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: new CountryPickerDialog(
            titlePadding: EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: InputDecoration(
                hintText:
                    Localization.of(context).trans(LocalizationValues.search) +
                        '...'),
            isSearchable: true,
            title: new Text(Localization.of(context)
                .trans(LocalizationValues.selectYourPhoneCode)),
            onValuePicked: onCountrySelected,
            itemBuilder: _buildDialogItem,
          ),
        ),
      );

  return new Stack(
    children: <Widget>[
      appThemedTextFieldOne(
        focusNode: focusNode,
        context: context,
        suffixAsset: suffixAsset,
        suffixSecondaryAsset: new InkWell(
          child: new Container(
//        color: Colors.blue,
            child: new Row(
              children: <Widget>[
                new Text(
                  "+${initialSelectedCountry.phoneCode}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: textStyle?.color ?? Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                new Icon(
                  Icons.expand_more,
                  color: textStyle?.color ?? Colors.white,
                  size: 15,
                ),
              ],
            ),
          ),
          onTap: _openCountryPickerDialog,
        ),
        controller: controller,
        label: label,
        validator: validator,
        obscureText: obscureText,
        inputFormatters: [
          WhitelistingTextInputFormatter(RegExp("[0-9]")),
          LengthLimitingTextInputFormatter(maxLength ?? 1000),
        ]..addAll(inputFormatters ?? []),
        keyboardType: TextInputType.phone,
        onPrefixOneTap: onPrefixTap,
        prefixOneAsset: prefixAsset,
        onFieldSubmitted: onFieldSubmitted,
        labelStyle: labelStyle,
        borderColor: borderColor,
        enabled: enabled,
        inputAction: inputAction,
        textStyle: textStyle,
      ),
      new Positioned.fill(
        child: new Offstage(
          offstage: enabled ?? true,
          child: new Container(
            color: Colors.cyanAccent.withOpacity(0.0),
          ),
        ),
      )
    ],
  );
}

// Returns "App themed text field" left sided label
Widget appThemedTextFieldTwo({
  @required String label,
  @required TextEditingController controller,
  @required BuildContext context,
  bool obscureText,
  @required FocusNode focusNode,
  TextInputType keyboardType,
  Function(String) validator,
  List<TextInputFormatter> inputFormatters,
  Function(String) onFieldSubmitted,
  bool enabled = true,
  bool autoValidate,
  TextStyle textStyle,
  TextStyle labelStyle,
  Color borderColor,
  int maxLines,
  int maxLength,
  Widget suffix,
  Widget prefix,
  TextInputAction inputAction,
  TextCapitalization textCapitalization,
}) {
  // Defaults
  const TextStyle defaultLabelStyle = const TextStyle(
    color: AppColors.kGrey,
    fontSize: 14.0,
  );
  final TextStyle defaultTextStyle = new TextStyle(
    //    fontWeight: FontWeight.w600,
    color: enabled ? Colors.black : Colors.black.withOpacity(0.6),
//    fontSize: 18.0,
  );
  const Color defaultBorderColor = AppColors.kGrey;
  final double _height = getScreenSize(context: context).height * 0.067;
  final double defaultHeight = _height > minimumDefaultButtonHeight
      ? _height
      : minimumDefaultButtonHeight;

  return new Card(
    elevation: 2.0,
    shape: const StadiumBorder(),
    child: new Stack(
      children: <Widget>[
        new Container(
          height: defaultHeight,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          child: new Row(
            children: <Widget>[
              prefix ?? new Container(),
              new SizedBox(
                width: 10,
              ),
              new Expanded(
                child: new TextFormField(
                  textInputAction: inputAction ?? TextInputAction.next,
                  controller: controller,
                  textCapitalization:
                      textCapitalization ?? TextCapitalization.none,
                  obscureText: obscureText ?? false,
                  focusNode: focusNode,
                  keyboardType: keyboardType,
                  validator: validator,
                  autovalidate: autoValidate ?? false,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(maxLength ?? 1000),
                  ]..addAll(inputFormatters ?? []),
                  onFieldSubmitted: onFieldSubmitted,
                  style: textStyle ?? defaultTextStyle,
                  maxLines: maxLines ?? 1,
                  decoration: new InputDecoration(
                    labelText: label,
                    labelStyle: labelStyle ?? defaultLabelStyle,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                      top: 0.0,
                      bottom: 0.0,
                    ),
                    errorStyle: new TextStyle(
                      fontSize: 10.0,
                      color: Colors.red,
                    ),
                    helperStyle: new TextStyle(
                      fontSize: 0.0,
                      color: Colors.black,
                    ),
                    isDense: true,
                  ),
                ),
              ),
              suffix ?? new Container(),
            ],
          ),
        ),
        new Positioned.fill(
          child: new Offstage(
            offstage: enabled,
            child: new Container(
              color: Colors.cyanAccent.withOpacity(0.0),
            ),
          ),
        ),
      ],
    ),
  );
}

// Returns "App themed Phone text field" centered label
Widget appThemedPhoneTextFieldTwo({
  @required String label,
  @required Country initialSelectedCountry,
  @required TextEditingController controller,
  @required BuildContext context,
  @required Function(Country) onCountrySelected,
  bool obscureText,
  @required FocusNode focusNode,
  TextInputType keyboardType,
  Function(String) validator,
  List<TextInputFormatter> inputFormatters,
  Function(String) onFieldSubmitted,
  bool enabled = true,
  TextStyle textStyle,
  TextStyle labelStyle,
  Color borderColor,
  Widget prefixAsset,
  Function onPrefixTap,
  TextInputAction inputAction,
  int maxLength,
}) {
  Widget _buildDialogItem(Country country) => new Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Text("+${country.phoneCode}"),
          SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      );

  void _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: new CountryPickerDialog(
            titlePadding: EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: InputDecoration(hintText: "Search" + '...'),
            isSearchable: true,
            title: Text("Select your phone code"),
            onValuePicked: onCountrySelected,
            itemBuilder: _buildDialogItem,
          ),
        ),
      );

  return appThemedTextFieldTwo(
    context: context,
    label: label,
    labelStyle: labelStyle,
    borderColor: borderColor,
    textStyle: textStyle,
    prefix: new InkWell(
      child: new Container(
//        color: Colors.cyanAccent,
        child: new Padding(
          padding: const EdgeInsets.only(
            bottom: 1.5,
          ),
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (prefixAsset != null) ? prefixAsset : Container(),
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: new Text("+${initialSelectedCountry.phoneCode}",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: AppColors.kGrey,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              new Icon(
                Icons.expand_more,
                color: AppColors.kGrey,
                size: 15,
              ),
            ],
          ),
        ),
      ),
      onTap: _openCountryPickerDialog,
    ),
    inputFormatters: [
      WhitelistingTextInputFormatter(RegExp("[0-9]")),
      LengthLimitingTextInputFormatter(maxLength ?? 1000),
    ]..addAll(inputFormatters ?? []),
    keyboardType: TextInputType.phone,
    controller: controller,
    obscureText: obscureText ?? false,
    focusNode: focusNode,
    validator: validator,
    onFieldSubmitted: onFieldSubmitted,
    enabled: enabled,
  );
}

// Returns "App themed text field" left sided label
Widget appThemedTextFieldThree({
  @required String label,
  @required TextEditingController controller,
  @required BuildContext context,
  bool obscureText,
  @required FocusNode focusNode,
  TextInputType keyboardType,
  Function(String) validator,
  List<TextInputFormatter> inputFormatters,
  Function(String) onFieldSubmitted,
  bool enabled = true,
  TextStyle textStyle,
  TextStyle labelStyle,
  Color borderColor,
  int maxLines,
  int maxLength,
  Widget suffix,
  Widget prefix,
}) {
  // Defaults
  const TextStyle defaultLabelStyle = const TextStyle(
    color: Colors.black,
    fontSize: 14.0,
  );
  final TextStyle defaultTextStyle = new TextStyle(
//    fontWeight: FontWeight.w600,
    color: enabled ? Colors.black : Colors.black.withOpacity(0.6),
    fontSize: 18.0,
  );
  const Color defaultBorderColor = AppColors.kGrey;

  return new Theme(
    data: new ThemeData(
      hintColor: AppColors.kAppBlack,
      primaryColor: AppColors.kAppBlack,
    ),
    child: new TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      focusNode: focusNode,
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength ?? 1000),
      ]..addAll(inputFormatters ?? []),
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
      style: textStyle ?? defaultTextStyle,
      maxLines: maxLines ?? 1,
      decoration: new InputDecoration(
        labelText: label,
        labelStyle: labelStyle ?? defaultLabelStyle,
//      border: InputBorder.none,
        contentPadding: const EdgeInsets.only(
          top: 5.0,
          bottom: 0.0,
        ),
        errorStyle: new TextStyle(
          fontSize: 10.0,
          color: Colors.red,
        ),
        helperStyle: new TextStyle(
          fontSize: 0.0,
        ),
        isDense: true,
        suffixIcon: suffix,
        prefixIcon: prefix,
      ),
    ),
  );
}

// Returns Ifinca themed Outline button
Widget getAppOutlineButton({
  @required VoidCallback onPressed,
  @required BuildContext context,
  Widget title,
  Color titleTextColor,
  @required String titleText,
  double height,
  Color backGroundColor,
  double borderRadius,
  double borderWidth,
  Color borderColor,
  bool inheritCc,
}) {
  // Defaults
  const double defaultBorderRadius = 30.0;
  const Color defaultBorderColor = Colors.white;
  const Color defaultBackGroundColor = Colors.transparent;
  const Color defaultDisabledBackgroundColor = Colors.grey;
  const double defaultBorderWidth = 0.8;
  final double _height = getScreenSize(context: context).height * 0.067;
  final double defaultHeight = _height > minimumDefaultButtonHeight
      ? _height
      : minimumDefaultButtonHeight;

  return new Material(
    color: onPressed != null
        ? backGroundColor ?? defaultBackGroundColor
        : defaultDisabledBackgroundColor,
    shape: StadiumBorder(),
    elevation: 0.0,
    clipBehavior: Clip.hardEdge,
    child: new InkWell(
      onTap: onPressed,
      child: new Container(
        height: height ?? defaultHeight,
        width: getScreenSize(context: context).width,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          border: new Border.all(
            color: borderColor ?? defaultBorderColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular((height ?? defaultHeight) / 2.0),
        ),
        child: new Text(
              titleText,
              style: new TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13.0,
                color: titleTextColor ?? Colors.white,
              ),
            ) ??
            title,
      ),
    ),
  );
}

// Returns Ifinca themed Raised button
Widget getIfincaRaisedButton({
  @required Widget title,
  @required VoidCallback onPressed,
  @required BuildContext context,
  Color backGroundColor,
}) {
  // Defaults

  const Color defaultBackGroundColor = AppColors.kOrange;
  const Color _defaultDisabledBG = AppColors.kGrey;
  final double _height = getScreenSize(context: context).height * 0.067;
  final double defaultHeight = _height > minimumDefaultButtonHeight
      ? _height
      : minimumDefaultButtonHeight;

  return new Material(
    color: onPressed != null
        ? backGroundColor ?? defaultBackGroundColor
        : _defaultDisabledBG,
//    borderRadius: new BorderRadius.circular(10.0),
    shape: StadiumBorder(),
    elevation: 3,
    clipBehavior: Clip.hardEdge,
    child: new InkWell(
      onTap: onPressed,
      child: new Container(
        height: defaultHeight,
        width: getScreenSize(context: context).width,
        alignment: Alignment.center,
        child: title,
      ),
    ),
  );
}

// Returns Ifinca themed flat button
Widget getAppFlatButton({
  @required BuildContext context,
  Widget title,
  @required String titleText,
  @required VoidCallback onPressed,
  double height,
  Color backGroundColor,
  Color textColor,
}) {
  // Defaults
  const Color defaultBackGroundColor = AppColors.kAppYellow;
  const Color defaultTextColor = Colors.white;

  final double _height = getScreenSize(context: context).height * 0.067;
  final double defaultHeight = _height > minimumDefaultButtonHeight
      ? _height
      : minimumDefaultButtonHeight;
  const Color defaultDisabledBackgroundColor = AppColors.kDisabledButtonColor;

  return Container(
    height: height ?? defaultHeight,
    width: getScreenSize(context: context).width,
    child: new FlatButton(
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
      onPressed: onPressed,
      child: new Text(
            titleText,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13.0,
                color: textColor ?? defaultTextColor),
          ) ??
          title,
      color: backGroundColor ?? defaultBackGroundColor,
      disabledColor: defaultDisabledBackgroundColor,
    ),
  );
}

// Returns spacer
Widget getSpacer({double height, double width}) {
  return new SizedBox(
    height: height ?? 0.0,
    width: width ?? 0.0,
  );
}

// Returns cached image
Widget getCachedNetworkImage(
    {@required String url, BoxFit fit, height, width}) {
  return new CachedNetworkImage(
    width: width ?? double.infinity,
    height: height ?? double.infinity,
    imageUrl: url ?? "",
    matchTextDirection: true,
    fit: fit,
    placeholder: (context, String val) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: new Center(
          child: new CupertinoActivityIndicator(),
        ),
      );
    },
    errorWidget: (BuildContext context, String error, Object obj) {
      return new Center(
        child: new Image.asset(
          AssetStrings.logoImage,
          fit: BoxFit.fill,
          color: Colors.grey,
          height: 24.0,
        ),
      );
    },
  );
}

// Returns ifinca themed Hexagon clip
Widget getHexagonClip(
    {@required Widget child, double elevation, Color backgroundColor}) {
  return new PhysicalShape(
    clipper: new HexagonClip(),
    color: backgroundColor ?? Colors.transparent,
    elevation: elevation ?? 0.0,
    child: new ClipPath(
      clipper: new HexagonClip(),
      child: child,
    ),
  );
}

// Returns ifinca themed Sloped bottom clip
Widget getSlopedBottomClip({@required Widget child}) {
  return new ClipPath(
    clipper: new SlopedBottomClip(),
    child: child,
  );
}

// Returns app themed list view loader
Widget getChildLoader({
  Color color,
  double strokeWidth,
}) {
  return new Center(
    child: new CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      valueColor: new AlwaysStoppedAnimation<Color>(
        color ?? Colors.white,
      ),
      strokeWidth: strokeWidth ?? 6.0,
    ),
  );
}

// Returns app themed loader
Widget getAppThemedLoader({
  @required BuildContext context,
  Color bgColor,
  Color color,
  double strokeWidth,
}) {
  return new Container(
    color: bgColor ?? const Color.fromRGBO(1, 1, 1, 0.6),
    height: getScreenSize(context: context).height,
    width: getScreenSize(context: context).width,
    child: getChildLoader(
      color: color ?? AppColors.kAppYellow,
      strokeWidth: strokeWidth,
    ),
  );
}

// Returns app themed loader
Widget getFullScreenLoader({
  @required Stream<bool> stream,
  @required BuildContext context,
  Color bgColor,
  Color color,
  double strokeWidth,
}) {
  return new StreamBuilder<bool>(
    stream: stream,
    initialData: false,
    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
      bool status = snapshot.data;
      return status
          ? getAppThemedLoader(
              context: context,
            )
          : new Container();
    },
  );
}

Widget appThemedDatePickerTextField({
  @required String label,
  @required TextEditingController controller,
  @required BuildContext context,
  bool obscureText,
  @required FocusNode focusNode,
  TextInputType keyboardType,
  Function(String) validator,
  List<TextInputFormatter> inputFormatters,
  Function(String) onFieldSubmitted,
  bool enabled,
  TextStyle textStyle,
  TextStyle labelStyle,
  Color borderColor,
  @required DateTime initialDate,
  DateTime lastDate,
  DateTime firstDate,
  @required Function(DateTime) onDatePicked,
  String dateFormat,
  @required String suffixAsset,
}) {
  return new GestureDetector(
    onTap: () async {
      DateTime _today = ((DateTime time) =>
          new DateTime.utc(time.year, time.month, time.day))(DateTime.now());

      DateTime _picked = await showDatePicker(
        context: context,
        firstDate: firstDate ?? _today,
        lastDate: lastDate ?? _today.add(new DateTime.now().timeZoneOffset),
        initialDate: initialDate ?? firstDate,
      );

      if (_picked != null) {
        controller.text = getFormattedDateString(
          format: "MMM dd, y",
          dateTime: _picked,
        );
        onDatePicked(_picked);
      }
    },
    child: new Stack(
      children: <Widget>[
        appThemedTextFieldOne(
          context: context,
          focusNode: focusNode,
          validator: validator,
          controller: controller,
          label: label,
          suffixAsset: suffixAsset,
        ),
        new Positioned(
          top: 0.0,
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: new Container(
            color: Colors.cyanAccent.withOpacity(
              0.0,
            ),
          ),
        ),
      ],
    ),
  );
}

//Widget appThemedTimePickerTextField({
//  @required String label,
//  @required TextEditingController controller,
//  @required BuildContext context,
//  bool obscureText,
//  @required FocusNode focusNode,
//  TextInputType keyboardType,
//  Function(String) validator,          // todo: acc time callback
//
//  List<TextInputFormatter> inputFormatters,
//  Function(String) onFieldSubmitted,
//  bool enabled,
//  TextStyle textStyle,
//  TextStyle labelStyle,
//  Color borderColor,
//  @required Function(TimeOfDay) onTimePicked,
//  String dateFormat,
//}) {
//  return new GestureDetector(
//    onTap: () async {
//      DateTime _today = ((DateTime time) =>
//          new DateTime.utc(time.year, time.month, time.day))(DateTime.now());
//      TimeOfDay _currentTime = new TimeOfDay.now();
//
//      TimeOfDay _picked = await showTimePicker(
//        initialTime: _currentTime,
//        context: context,
//      );
//
//      if (_picked != null) {
//        DateTime tempDate = new DateTime(2019,1,12,_picked.hour,_picked.minute);
//        controller.text = new DateFormat.jm().format(tempDate);
//        onTimePicked(_picked);
//      }
//    },
//    child: new Stack(
//      children: <Widget>[
//        appThemedTextFieldTwo(
//          context: context,
//          focusNode: focusNode,
//          validator: validator,
//          controller: controller,
//          label: label,
//        ),
//        new Positioned(
//          top: 0.0,
//          bottom: 0.0,
//          left: 0.0,
//          right: 0.0,
//          child: new Container(
//            color: Colors.cyanAccent.withOpacity(
//              0.0,
//            ),
//          ),
//        ),
//      ],
//    ),
//  );
//}

// Returns app themed pop up menu text field one
Widget appThemedCheckListPopUpTextFieldOne({
  @required String label,
  @required String popUpTitle,
  @required TextEditingController controller,
  @required BuildContext context,
  @required List<int> selectedOptions,
  @required String otherSelectedOption,
  bool obscureText,
  bool multipleSelection = true,
  @required FocusNode focusNode,
  TextInputType keyboardType,
  Function(String) validator,
  List<TextInputFormatter> inputFormatters,
  Function(String) onFieldSubmitted,
  bool enabled,
  TextStyle textStyle,
  TextStyle labelStyle,
  Color borderColor,
  Color dropDownIconColor,
  @required Map<String, String> options,
  Function(Map<String, String>) onOptionsRefresh,
  Future<Map<String, String>> Function() refreshOptions,
  bool allowInput = false,
  @required Function(List<int>, {String other}) onDone,
}) {
  List<String> _options = options.keys.toList();
  List<String> _values = options.values.toList();

  // Sets selected options string in text field
  void setSelectedString({
    @required List<int> selectedOptions,
    @required String other,
  }) {
    String selectedOptionsString = "";

    if (selectedOptions != null && (_options?.isNotEmpty ?? false)) {
      for (int index = 0; index < selectedOptions.length; index++) {
        if (selectedOptions[index] != -1) {
          selectedOptionsString =
              (selectedOptionsString + _options[selectedOptions[index]]) +
                  (index == selectedOptions.length - 1 ? "" : ", ");
        }
      }
    }
    if (other != null) {
      selectedOptionsString = selectedOptionsString +
          (selectedOptionsString.isEmpty ? "" : ", ") +
          other;
    }
    controller.text = selectedOptionsString;
  }

  setSelectedString(
    selectedOptions: selectedOptions,
    other: otherSelectedOption,
  );

  return new Stack(
    children: <Widget>[
      appThemedTextFieldOne(
        focusNode: focusNode,
        context: context,
        suffixAsset: null,
        controller: controller,
        label: label,
        validator: validator,
        obscureText: obscureText,
        onFieldSubmitted: onFieldSubmitted,
        labelStyle: labelStyle,
        borderColor: borderColor,
        enabled: false,
        maxLines: 3,
        prefixTwoAsset: new Align(
          alignment: Alignment.bottomRight,
          child: new Icon(
            Icons.keyboard_arrow_down,
            color: dropDownIconColor ?? Colors.white,
          ),
        ),
        textStyle: textStyle,
      ),
      new Positioned.fill(
        child: new InkWell(
          onTap: () async {
            showDialog(
                context: context,
                builder: (context) {
                  return new Dialog(
                    child: new CheckBoxListPopUpMenu(
                      options: options,
                      title: popUpTitle,
                      onOptionsRefresh: onOptionsRefresh,
                      refresh: refreshOptions,
                      label: label,
                      multipleSelection: multipleSelection,
                      selectedOptions: selectedOptions,
                      otherSelectedOption: otherSelectedOption,
                      onDone: (newSelectedOptions,
                          {String other,
                          Map<String, String> updatedOptionsList}) {
                        if (updatedOptionsList.isNotEmpty) {
                          _options = updatedOptionsList.keys.toList();
                        }
                        String _other = other ?? "";
                        if (newSelectedOptions != null) {
                          setSelectedString(
                            selectedOptions: newSelectedOptions,
                            other: _other,
                          );
                        }
                        if (onDone != null) {
                          onDone(
                            newSelectedOptions ?? [],
                            other: _other,
                          );
                        }
                      },
                    ),
                  );
                });
          },
          child: new Container(
            color: Colors.white.withOpacity(0.0),
          ),
        ),
      ),
    ],
  );
}

// Returns app themed pop up textfield one
Widget appThemedPopUpTextFieldOne({
  @required String label,
  @required TextEditingController controller,
  @required BuildContext context,
  bool obscureText,
  @required FocusNode focusNode,
  TextInputType keyboardType,
  Function(String) validator,
  List<TextInputFormatter> inputFormatters,
  Function(String) onFieldSubmitted,
  bool enabled = true,
  TextStyle textStyle,
  TextStyle labelStyle,
  Color borderColor,
  Color dropDownIconColor,
  @required Map<String, String> options,
  bool allowInput = false,
  VoidCallback onValueChanged,
}) {
  List _options = options.keys.toList();
  List _values = options.values.toList();

  return new Stack(
    children: <Widget>[
      new PopupMenuButton<String>(
        child: new Stack(
          children: <Widget>[
            appThemedTextFieldOne(
              focusNode: focusNode,
              context: context,
              suffixAsset: null,
              controller: controller,
              label: label,
              validator: validator,
              obscureText: obscureText,
              onFieldSubmitted: onFieldSubmitted,
              labelStyle: labelStyle,
              borderColor: borderColor,
              enabled: false,
              prefixTwoAsset: new Align(
                alignment: Alignment.bottomRight,
                child: options.isEmpty
                    ? new CupertinoActivityIndicator(
                        radius: 8.0,
                      )
                    : new Icon(
                        Icons.keyboard_arrow_down,
                        color: dropDownIconColor ?? Colors.white,
                      ),
              ),
              textStyle: textStyle,
            ),
            new Positioned.fill(
              child: new Container(
                color: Colors.cyanAccent.withOpacity(0.0),
              ),
            ),
          ],
        ),
        onSelected: (String result) {
          controller.text = result;
          if (onValueChanged != null) {
            onValueChanged();
          }
        },
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<String>>[]..addAll(
                new List.generate(
                  options.keys.length,
                  (int index) {
                    return new PopupMenuItem<String>(
                      value: _options[index],
                      child: new Text(_values[index]),
                    );
                  },
                ),
              ),
      ),
      new Positioned.fill(
        child: new Visibility(
          visible: !enabled || options.isEmpty,
          child: new Container(
            color: Colors.cyanAccent.withOpacity(0.0),
          ),
        ),
      ),
    ],
  );
}

// Returns app themed pop up textfield two
Widget appThemedPopUpTextFieldTwo({
  @required String label,
  @required TextEditingController controller,
  @required BuildContext context,
  bool obscureText,
  @required FocusNode focusNode,
  TextInputType keyboardType,
  Function(String) validator,
  List<TextInputFormatter> inputFormatters,
  Function(String) onFieldSubmitted,
  bool enabled,
  TextStyle textStyle,
  TextStyle labelStyle,
  Color borderColor,
  @required Map<String, String> options,
  bool allowInput = false,
  VoidCallback onValueChanged,
}) {
  Map<String, String> optionsList = enabled ? options : {};
  List _options = optionsList.keys.toList();
  List _values = optionsList.values.toList();

  return new Stack(
    children: <Widget>[
      new PopupMenuButton<String>(
        child: new Stack(
          children: <Widget>[
            appThemedTextFieldTwo(
              focusNode: focusNode,
              context: context,
              controller: controller,
              label: label,
              validator: validator,
              obscureText: obscureText,
              onFieldSubmitted: onFieldSubmitted,
              labelStyle: labelStyle,
              borderColor: borderColor,
              enabled: false,
              textStyle: textStyle,
            ),
            new Positioned.fill(
              child: new Container(
                color: Colors.cyanAccent.withOpacity(0.0),
              ),
            ),
          ],
        ),
        onSelected: (String result) {
          controller.text = result;
          if (onValueChanged != null) {
            onValueChanged();
          }
        },
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<String>>[]..addAll(
                new List.generate(
                  optionsList.keys.length,
                  (int index) {
                    return new PopupMenuItem<String>(
                      value: _options[index],
                      child: new Text(_values[index]),
                    );
                  },
                ),
              ),
      ),
      new Positioned(
        top: 0.0,
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: new Offstage(
          offstage: optionsList.isNotEmpty,
          child: new Container(
            color: Colors.cyanAccent.withOpacity(0.0),
          ),
        ),
      ),
    ],
  );
}

getAppThemeAppBar(context,
    {bool canRouteBack: true,
    Widget title,
    Widget actionButton,
    titleText: ""}) {
  return PreferredSize(
    preferredSize: new AppBar().preferredSize,
    child: SafeArea(
      top: true,
      child: Container(
        height: new AppBar().preferredSize.height,
        child: AppBar(
          backgroundColor: AppColors.kGreen,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: canRouteBack
              ? new InkWell(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: new Image.asset(
                      AssetStrings.backIconWhite,
                      scale: 4,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              : null,
          title: title == null
              ? new Text(
                  "$titleText",
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                )
              : title,
          actions: <Widget>[
            actionButton ??
                Container(
                  height: 0,
                  width: 0,
                )
          ],
        ),
      ),
    ),
  );
}

// Returns "App themed text field" left sided label
Widget chatTextField({
  @required String label,
  @required TextEditingController controller,
  @required BuildContext context,
  bool obscureText,
  @required FocusNode focusNode,
  TextInputType keyboardType,
  Function(String) validator,
  List<TextInputFormatter> inputFormatters,
  Function(String) onFieldSubmitted,
  bool enabled = true,
  bool autoValidate,
  TextStyle textStyle,
  TextStyle labelStyle,
  Color borderColor,
  int maxLines,
  int maxLength,
  Widget suffix,
  Widget prefix,
  TextInputAction inputAction,
  TextCapitalization textCapitalization,
}) {
  // Defaults
  const TextStyle defaultLabelStyle = const TextStyle(
    color: AppColors.kGrey,
    fontSize: 14.0,
  );
  final TextStyle defaultTextStyle = new TextStyle(
    //    fontWeight: FontWeight.w600,
    color: enabled ? Colors.black : Colors.black.withOpacity(0.6),
//    fontSize: 18.0,
  );
  const Color defaultBorderColor = AppColors.kGrey;
  final double _height = getScreenSize(context: context).height * 0.067;
  final double defaultHeight = _height > minimumDefaultButtonHeight
      ? _height
      : minimumDefaultButtonHeight;

  return new Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(defaultHeight))),
    child: new Stack(
      children: <Widget>[
        new Container(
//          constraints: BoxConstraints(
//            maxHeight: 150,
//            minHeight: 0.0
//          ),

          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          child: new Row(
            children: <Widget>[
              prefix ?? new Container(),
              new SizedBox(
                width: 10,
              ),
              new Expanded(
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 120,
                    minHeight: defaultHeight,
                  ),
                  child: new TextFormField(
                    textInputAction: inputAction ?? TextInputAction.next,
                    controller: controller,
                    textCapitalization:
                        textCapitalization ?? TextCapitalization.none,
                    obscureText: obscureText ?? false,
                    focusNode: focusNode,
                    keyboardType: keyboardType,
                    validator: validator,
                    autovalidate: autoValidate ?? false,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(maxLength ?? 1000),
                    ]..addAll(inputFormatters ?? []),
                    onFieldSubmitted: onFieldSubmitted,
                    style: textStyle ?? defaultTextStyle,
                    maxLines: null,
                    //maxLines ?? 1,
                    decoration: new InputDecoration(
                      labelText: label,
                      labelStyle: labelStyle ?? defaultLabelStyle,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                        top: 0.0,
                        bottom: 0.0,
                      ),
                      errorStyle: new TextStyle(
                        fontSize: 10.0,
//                      color: labelStyle?.color ?? defaultLabelStyle?.color,
                      ),
                      helperStyle: new TextStyle(
                        fontSize: 0.0,
                        color: Colors.black,
                      ),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              suffix ?? new Container(),
            ],
          ),
        ),
        new Positioned.fill(
          child: new Offstage(
            offstage: enabled,
            child: new Container(
              color: Colors.cyanAccent.withOpacity(0.0),
            ),
          ),
        ),
      ],
    ),
  );
}

_getSpace({double height}) {
  return SizedBox(height: height);
}

//default retry
getRetryView(
    {@required BuildContext context,
    String message,
    imgUrl: AssetStrings.loan,
    onRetry,
    optionText: "RETRY"}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      (_getSpace(height: getScreenSize(context: context).height * 0.1)),
      Image.asset(
        imgUrl,
        height: getScreenSize(context: context).height * 0.2,
      ),
      _getSpace(height: getScreenSize(context: context).height * 0.02),
      Text(
        message ?? "",
        style: TextStyle(),
        textAlign: TextAlign.center,
      ),
      _getSpace(height: getScreenSize(context: context).height * 0.06),
      getAppFlatButton(
          context: context,
          backGroundColor: AppColors.kGreen,
          titleText: optionText,
          onPressed: onRetry),
    ],
  );
}

getNoItemView({imgUrl: AssetStrings.loan, text: "", context}) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Image.asset(
          imgUrl,
          height: getScreenSize(context: context).height * 0.2,
        ),
        _getSpace(height: getScreenSize(context: context).height * 0.02),
        Text(text),
      ],
    ),
  );
}

Widget appTextField({
  @required String label,
  @required TextEditingController controller,
  @required BuildContext context,
  bool obscureText,
  @required FocusNode focusNode,
  TextInputType keyboardType,
  Function(String) validator,
  List<TextInputFormatter> inputFormatters,
  Function(String) onFieldSubmitted,
  bool enabled = true,
  bool autoValidate,
  TextStyle textStyle,
  TextStyle labelStyle,
  Color borderColor,
  int maxLines,
  int maxLength,
  Widget suffix,
  Widget prefix,
  TextInputAction inputAction,
  TextCapitalization textCapitalization,
}) {
  // Defaults
  const TextStyle defaultLabelStyle = const TextStyle(
    color: AppColors.kGrey,
    fontSize: 14.0,
  );
  final TextStyle defaultTextStyle = new TextStyle(
    //    fontWeight: FontWeight.w600,
    color: enabled ? Colors.black : Colors.black.withOpacity(0.6),
//    fontSize: 18.0,
  );
  const Color defaultBorderColor = AppColors.kGrey;
  final double _height = getScreenSize(context: context).height * 0.067;

  return new TextFormField(
    textInputAction: inputAction ?? TextInputAction.next,
    controller: controller,
    textCapitalization: textCapitalization ?? TextCapitalization.none,
    obscureText: obscureText ?? false,
    focusNode: focusNode,
    keyboardType: keyboardType,
    validator: validator,
    autovalidate: autoValidate ?? false,
    inputFormatters: [
      LengthLimitingTextInputFormatter(maxLength ?? 1000),
    ]..addAll(inputFormatters ?? []),
    onFieldSubmitted: onFieldSubmitted,
    style: textStyle ?? defaultTextStyle,
    maxLines: maxLines ?? 1,
    decoration: new InputDecoration(
      labelText: label,
      labelStyle: labelStyle ?? defaultLabelStyle,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32))),
      contentPadding: const EdgeInsets.only(
        top: 0.0,
        bottom: 0.0,
      ),
      errorStyle: new TextStyle(
        fontSize: 10.0,
        color: Colors.red,
      ),
      helperStyle: new TextStyle(
        fontSize: 0.0,
        color: Colors.black,
      ),
      isDense: true,
    ),
  );
}

Widget textFieldWidget({
  String hint,
  IconData icon,
  TextEditingController controller,
  FocusNode focusNode,
  bool obscureText,
  Function(String) validator,
  Function(String) onFieldSubmitted,
  TextCapitalization textCapitalization,
  TextInputAction inputAction,
  TextInputType keyboardType,
}) {
  return Theme(
    data: ThemeData(
      primaryColor: AppColors.kGreen,
    ),
    child: Container(
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText ?? false,
        focusNode: focusNode,
        validator: validator,
        maxLines: 1,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        onFieldSubmitted: onFieldSubmitted,
        cursorColor: AppColors.kGreen,
        textInputAction: inputAction ?? TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: hint,
//          contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32))),
        ),
      ),
    ),
  );
}

Widget getToast({@required String msg}){
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