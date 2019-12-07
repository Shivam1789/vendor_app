import 'package:flutter/material.dart';
import 'package:vendor_flutter/Utils/AppColors.dart';
import 'package:vendor_flutter/Utils/AssetStrings.dart';
import 'package:vendor_flutter/Utils/ReusableWidgets.dart';
import 'package:vendor_flutter/Utils/UniversalFunctions.dart';
import 'package:vendor_flutter/Utils/ValidatorFunctions.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _nameController = new TextEditingController();
  final GlobalKey<FormState> _FormKey = new GlobalKey<FormState>();
  final FocusNode _nameFocusNode = new FocusNode();

  Widget get _getBackgroundImage {
    return Container(
        height: getScreenSize(context: context).height / 1.14,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AssetStrings.signInBg), fit: BoxFit.fill),
        ));
  }

  get _getForgotTxt => Text(
        "Need help logging in?",
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      );

  get _getDesc => Text(
        "Tell us your email and we will send you a link to login.",
        style: TextStyle(
            color: Colors.white, fontSize: 14),
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          _getBackgroundImage,
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      getSpacer(height: 40),
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, size: 30,color: AppColors.kWhite,),
                        onPressed: () {},
                      ),
                      getSpacer(
                        height: getScreenSize(context: context).height * 0.04,
                      ),
                      _getForgotTxt,
                      getSpacer(height: 8),
                      _getDesc,
                      getSpacer(height: 60),
                      _emailField(),
                      getSpacer(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          getForgotBtn(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
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

  Widget getForgotBtn() {
    return SizedBox(
      width: getScreenSize(context: context).width / 1.5,
      height: 48,
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(14.0)),
        onPressed: () {},
        color: AppColors.kJerryAppColor,
        textColor: Colors.white,
        child: Text("Send Email",
            style: TextStyle(
              fontSize: 14,
            )),
      ),
    );
  }
}
