import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vendor_flutter/Utils/AppColors.dart';
import 'package:vendor_flutter/Utils/AssetStrings.dart';
import 'package:vendor_flutter/Utils/ReusableWidgets.dart';
import 'package:vendor_flutter/Utils/UniversalFunctions.dart';
import 'package:vendor_flutter/Utils/ValidatorFunctions.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();

  // Global keys
  final GlobalKey<FormState> _editFormKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // Focus Nodes
  final FocusNode _nameFocusNode = new FocusNode();
  final FocusNode _phoneFocusNode = new FocusNode();
  TapGestureRecognizer termsCondition;

  var underlineStyle = TextStyle(
      decoration: TextDecoration.underline,
      color: AppColors.kJerryAppColor,
      fontSize: 11);

  get _getBottomTxt {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            "Don't have an account? Sign Up",
            style: new TextStyle(
                fontSize: 11,
                color: AppColors.kAppBlack),
          ),
          getSpacer(width: 4),
          new RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "here",
                  style: underlineStyle,
                  recognizer: termsCondition,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailField() {
    return customTextField(
      controller: _nameController,
      hint: "Email",
      focusNode: _nameFocusNode,
      validator: (value) {
        return usernameValidator(name: value, context: context);
      },
      onFieldSubmitted: (val) {
        setFocusNode(context: context, focusNode: _phoneFocusNode);
      },
      inputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      icon: Image.asset(
        AssetStrings.signInEmailIcon,
        color: Colors.white,
      ),
    );
  }

  Widget _passwordField() {
    return customTextField(
      controller: _phoneController,
      hint: "Password",
      focusNode: _phoneFocusNode,
      validator: (value) {
        return usernameValidator(name: value, context: context);
      },
      inputAction: TextInputAction.done,
      keyboardType: TextInputType.emailAddress,
      icon: new Image.asset(
        AssetStrings.signInPassword,
      ),
    );
  }

  get _getLoginIcon => Image.asset(
        AssetStrings.signInIcon,
        height: 80,
        width: 80,
      );

  Widget get _getBackgroundImage {
    return Container(
        height: getScreenSize(context: context).height / 1.14,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AssetStrings.signInBg), fit: BoxFit.fill),
        ));
  }

  get _getSignIn => Text(
        "Sign In",
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      );

  get _getSignInDesc => Text(
        "Welcome back and glad to see you",
        style: TextStyle(color: Colors.white, fontSize: 12),
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: new Stack(
        children: <Widget>[
          _getBackgroundImage,
          Scaffold(
            backgroundColor: Colors.transparent,
            key: _scaffoldKey,
            body: GestureDetector(
              onTap: () {
                closeKeyboard(
                  context: context,
                  onClose: () {},
                );
              },
              child: SingleChildScrollView(
                child: new Form(
                  key: _editFormKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        getSpacer(height: 80),
                        _getLoginIcon,
                        getSpacer(height: 10),
                        _getSignIn,
                        getSpacer(height: 10),
                        _getSignInDesc,
                        getSpacer(height: 10),
                        _emailField(),
                        getSpacer(
                          height: getScreenSize(context: context).height * 0.02,
                        ),
                        _passwordField(),
                        getSpacer(
                          height: getScreenSize(context: context).height * 0.30,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [getSignInBtn()]),
                        getSpacer(
                          height: getScreenSize(context: context).height * 0.02,
                        ),
                        _getBottomTxt,
                        getSpacer(height: 10)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget customTextField({
    String hint,
    Widget icon,
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
        primaryColor: AppColors.kWhite,
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
          cursorColor: AppColors.kWhite,
          textInputAction: inputAction ?? TextInputAction.next,
          decoration: InputDecoration(prefixIcon: icon, labelText: hint),
        ),
      ),
    );
  }

  Widget getSignInBtn() {
    return SizedBox(
      width: getScreenSize(context: context).width / 1.5,
      height: 48,
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(14.0)),
        onPressed: () {},
        color: AppColors.kJerryAppColor,
        textColor: Colors.white,
        child: Text("Sign In",
            style: TextStyle(
              fontSize: 14,
            )),
      ),
    );
  }
}
