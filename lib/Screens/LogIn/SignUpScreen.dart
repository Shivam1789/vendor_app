import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vendor_flutter/Utils/AppColors.dart';
import 'package:vendor_flutter/Utils/AssetStrings.dart';
import 'package:vendor_flutter/Utils/ReusableComponents/WebViewScaffold.dart';
import 'package:vendor_flutter/Utils/ReusableWidgets.dart';
import 'package:vendor_flutter/Utils/UniversalFunctions.dart';
import 'package:vendor_flutter/Utils/ValidatorFunctions.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Controllers

  final StreamController<bool> _loaderStreamController =
      new StreamController<bool>();

//  SignUpBloc _signUpBloc = new SignUpBloc();

  // Focus Nodes
  final FocusNode _nameFocusNode = new FocusNode();
  final FocusNode _phoneFocusNode = new FocusNode();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController password = new TextEditingController();

  // Global keys
  final GlobalKey<FormState> _signUpFormKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // Data props.

//  Country _selectedDialogCountry =
//      CountryPickerUtils.getCountryByPhoneCode('57');

  //UI Properties
  var underlineStyle = TextStyle(
      decoration: TextDecoration.underline,
      color: AppColors.kGreen,
      fontSize: 14);
  TapGestureRecognizer termsCondition;
  TapGestureRecognizer privacyPolicy;

  // Getters

  // Returns name field
  get _getNameField {
    return appThemedTextFieldTwo(
      context: context,
      label: "Email",
      controller: nameController,
      focusNode: _nameFocusNode,
      validator: (value) {
        return emailPhoneValidator(email: value, context: context);
      },
      onFieldSubmitted: (val) {
        setFocusNode(context: context, focusNode: _phoneFocusNode);
      },
      maxLength: 45,
      textCapitalization: TextCapitalization.words,
      prefix: Icon(
        FontAwesomeIcons.mailBulk,
        size: 20,
      ),
    );
  }

  // Returns phone field
  get _getPhoneField {
    return appThemedTextFieldTwo(
      context: context,
      label: "Password",
      controller: password,
      focusNode: _phoneFocusNode,
      validator: (value) {
        return enteredPasswordValidator(enteredPassword: value, context: context);
      },
      onFieldSubmitted: (val) {
        setFocusNode(context: context, focusNode: _phoneFocusNode);
      },
      maxLength: 45,
      prefix: Icon(
        FontAwesomeIcons.lock,
        size: 20,
      ),
      obscureText: true
    );
  }

  //Returns terms and condition and privacy policy widget
  get _getTermsAndCondition {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: <Widget>[
          new Text(
            "By Logging in I accept to all the",
            style: new TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: AppColors.kAppBlack),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: new RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "Terms and Conditions",
                    style: underlineStyle,
                    recognizer: termsCondition,
                  ),
                  TextSpan(
                      text: ' and ',
                      style: TextStyle(
                        color: AppColors.kAppBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      )),
                  TextSpan(
                    text: "Privacy Policy",
                    style: underlineStyle,
                    recognizer: privacyPolicy,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Returns login button
  get _getSignUpButton {
    return getAppFlatButton(
      context: context,
      backGroundColor: AppColors.kGreen,
      titleText: "SUBMIT",
      onPressed: () {
        closeKeyboard(context: context, onClose: () {});
        if (_signUpFormKey.currentState.validate()) {
//          Navigator.of(context).pushAndRemoveUntil(
//              MaterialPageRoute(builder: (context) {
//                return Dashboard();
//              }), (Route<dynamic> route) => false);
        }
      },
    );
  }

  // Returns loader
  get _getLoader {
    return getFullScreenLoader(
      stream: _loaderStreamController.stream,
      context: context,
    );
  }

  // Returns sign up label
  get _getSignUpLabel {
    return new Align(
      alignment: Alignment.center,
      child: new Text(
        "Log In",
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initialization();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        getAppThemedBGOne(),
        new Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          body: new GestureDetector(
            onTap: () {
              closeKeyboard(
                context: context,
                onClose: () {},
              );
            },
            child: new SafeArea(
              child: new Form(
                key: _signUpFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: new SingleChildScrollView(
                    child: new Container(
                      height: getScreenSize(context: context).height -
                          getStatusBarHeight(context: context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Column(
                            children: <Widget>[
//                              getSpacer(
//                                height: 15,
//                              ),
//                              getBackButton(context, false),
                              getSpacer(
                                height: getScreenSize(context: context).height *
                                    0.07,
                              ),
                              _getSignUpLabel,
                              getSpacer(
                                height: getScreenSize(context: context).height *
                                    0.1,
                              ),
                              _getNameField,
                              getSpacer(
                                height: getScreenSize(context: context).height *
                                    0.02,
                              ),
                              _getPhoneField,
                              getSpacer(
                                height: getScreenSize(context: context).height *
                                    0.02,
                              ),
                              _getSignUpButton,
                            ],
                          ),
                          new Column(
                            children: <Widget>[
                              _getTermsAndCondition,
                              getSpacer(
                                height: 35,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        new Center(
          child: _getLoader,
        ),
      ],
    );
  }

  // Methods
  void _initialization() {
    termsCondition = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) =>
                  new WebViewScaffold(title: "Terms  & Conditions", url: "")),
        );
      };
    privacyPolicy = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) =>
                  new WebViewScaffold(title: "Privacy Policy ", url: "")),
        );
      };
  }

  // Disposes controllers
  void _dispose() {
    _loaderStreamController.close();
  }
}
