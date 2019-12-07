import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vendor_flutter/Utils/AppColors.dart';
import 'package:vendor_flutter/Utils/AssetStrings.dart';
import 'package:vendor_flutter/Utils/ReusableWidgets.dart';
import 'package:vendor_flutter/Utils/UniversalFunctions.dart';
import 'package:vendor_flutter/Utils/ValidatorFunctions.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController =
      new TextEditingController();
  final TextEditingController _lastNameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _birthdayController = new TextEditingController();

  final FocusNode _firstNameFocusNode = new FocusNode();
  final FocusNode _lastNameFocusNode = new FocusNode();
  final FocusNode _emailFocusNode = new FocusNode();
  final FocusNode _passwordFocusNode = new FocusNode();
  final FocusNode _birthadyFocusNode = new FocusNode();
  final format = DateFormat("yyyy-MM-dd");

  get _getSignUp => Text(
        "Sign Up",
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          _getBackgroundImage,
          Scaffold(
            backgroundColor: Colors.transparent,
            body: GestureDetector(
              onTap: () {
                closeKeyboard(
                  context: context,
                  onClose: () {},
                );
              },
              child: SingleChildScrollView(
                child: Form(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      getSpacer(height: 40),
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, size: 30,color: AppColors.kWhite,),
                        onPressed: () {},
                      ),
                      getSpacer(
                        height: getScreenSize(context: context).height * 0.02,
                      ),
                      _getSignUp,
                      getSpacer(
                        height: getScreenSize(context: context).height * 0.02,
                      ),
                      _emailField(),
                      getSpacer(
                        height: getScreenSize(context: context).height * 0.02,
                      ),
                      _firstNameField(),
                      getSpacer(
                        height: getScreenSize(context: context).height * 0.02,
                      ),
                      _lastNameField(),
                      getSpacer(
                        height: getScreenSize(context: context).height * 0.02,
                      ),
                      _passwordField(),
                      getSpacer(
                        height: getScreenSize(context: context).height * 0.02,
                      ),
                      //getDateField(hint: "Birthday"),
                      _getBirthdayField(),
                      getSpacer(
                        height: getScreenSize(context: context).height * 0.099,
                      ),
                      _getSubmitBtn()
                    ],
                  ),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _emailField() {
    return customTextField(
      controller: _emailController,
      hint: "Email",
      focusNode: _emailFocusNode,
      validator: (value) {
        return emailValidator(email: value, context: context);
      },
      onFieldSubmitted: (val) {
        setFocusNode(context: context, focusNode: _firstNameFocusNode);
      },
      inputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      icon: Image.asset(
        AssetStrings.signInEmailIcon,
        color: Colors.white,
      ),
    );
  }

  Widget _firstNameField() {
    return customTextField(
      controller: _firstNameController,
      hint: "First Name",
      focusNode: _firstNameFocusNode,
      validator: (value) {
        return emailValidator(email: value, context: context);
      },
      onFieldSubmitted: (val) {
        setFocusNode(context: context, focusNode: _lastNameFocusNode);
      },
      inputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      icon: Image.asset(
        AssetStrings.signInEmailIcon,
        color: Colors.white,
      ),
    );
  }

  Widget _lastNameField() {
    return customTextField(
      controller: _lastNameController,
      hint: "Last Name",
      focusNode: _lastNameFocusNode,
      validator: (value) {
        return emailValidator(email: value, context: context);
      },
      onFieldSubmitted: (val) {
        setFocusNode(context: context, focusNode: _passwordFocusNode);
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
      controller: _passwordController,
      hint: "Password",
      focusNode: _passwordFocusNode,
      validator: (value) {
        return usernameValidator(name: value, context: context);
      },
      inputAction: TextInputAction.next,
      onFieldSubmitted: (val) {
        setFocusNode(context: context, focusNode: _birthadyFocusNode);
      },
      keyboardType: TextInputType.emailAddress,
      icon: new Image.asset(
        AssetStrings.signInPassword,
      ),
    );
  }

  Widget get _getBackgroundImage {
    return Container(
        height: getScreenSize(context: context).height / 1.14,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AssetStrings.signInBg), fit: BoxFit.fill),
        ));
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

  Widget _getBirthdayField() {
    return customTextField(
      controller: _birthdayController,
      hint: "Birthday",
      focusNode: _birthadyFocusNode,
      validator: (value) {
        return emailValidator(email: value, context: context);
      },
      inputAction: TextInputAction.done,
      keyboardType: TextInputType.emailAddress,
      icon: Image.asset(
        AssetStrings.signInEmailIcon,
        color: Colors.white,
      ),
    );
  }

  Widget _getSubmitBtn() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        width: getScreenSize(context: context).width / 1.5,
        height: 48,
        child: RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(14.0)),
          onPressed: () {},
          color: AppColors.kJerryAppColor,
          textColor: Colors.white,
          child: Text("Submit",
              style: TextStyle(
                fontSize: 14,
              )),
        ),
      ),
    ]);
  }
}
