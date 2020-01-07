import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:vendor_flutter/Utils/AppColors.dart';
import 'package:vendor_flutter/Utils/Messages.dart';
import 'package:vendor_flutter/Utils/ReusableComponents/customLoader.dart';
import 'package:vendor_flutter/Utils/ReusableWidgets.dart';
import 'package:vendor_flutter/Utils/UniversalFunctions.dart';
import 'package:vendor_flutter/Utils/ValidatorFunctions.dart';
import 'package:vendor_flutter/Utils/memory_management.dart';
import 'package:vendor_flutter/networks/api_urls.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _subjectController = new TextEditingController();
  final TextEditingController _messageController = new TextEditingController();

  final FocusNode _nameFocusNode = new FocusNode();
  final FocusNode _emailFocusNode = new FocusNode();
  final FocusNode _phoneFocusNode = new FocusNode();
  final FocusNode _subjectFocusNode = new FocusNode();
  final FocusNode _messageFocusNode = new FocusNode();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  CustomLoader _customLoader = CustomLoader();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    getSpacer(height: 40),
                    _getNameField,
                    getSpacer(height: 20),
                    _getemailField,
                    getSpacer(height: 20),
                    _getPhoneField,
                    getSpacer(height: 20),
                    _getSubjectField,
                    getSpacer(height: 20),
                    _getMessageField,
                    getSpacer(height: 20),
                    _getSubmitButton,
                    getSpacer(
                      height: getScreenSize(context: context).height * 0.02,
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  // Returns name field
  get _getNameField {
    return textFieldWidget(
        context: context,
        label: "Name",
        focusNode: _nameFocusNode,
        controller: _nameController,
        validator: (value) {
          return usernameValidator(name: value, context: context);
        },
        keyboardType: TextInputType.text,
        onFieldSubmitted: (val) {
          setFocusNode(context: context, focusNode: _emailFocusNode);
        },
        inputAction: TextInputAction.next,
        icon: Icon(
          FontAwesomeIcons.userFriends,
          size: 20,
        ));
  }

  get _getemailField {
    return textFieldWidget(
        context: context,
        label: "Email",
        focusNode: _emailFocusNode,
        controller: _emailController,
        validator: (value) {
          return emailValidator(email: value, context: context);
        },
        keyboardType: TextInputType.emailAddress,
        onFieldSubmitted: (val) {
          setFocusNode(context: context, focusNode: _phoneFocusNode);
        },
        inputAction: TextInputAction.next,
        icon: Icon(
          FontAwesomeIcons.envelopeOpen,
          size: 20,
        ));
  }

  get _getPhoneField {
    return textFieldWidget(
        context: context,
        label: "Phone Number",
        focusNode: _phoneFocusNode,
        controller: _phoneController,
        validator: (value) {
          return phoneNumberValidator(phoneNumber: value, context: context);
        },
        keyboardType: TextInputType.phone,
        onFieldSubmitted: (val) {
          setFocusNode(context: context, focusNode: _subjectFocusNode);
        },
        inputAction: TextInputAction.next,
        icon: Icon(
          FontAwesomeIcons.phoneAlt,
          size: 20,
        ));
  }

  get _getSubjectField {
    return textFieldWidget(
        context: context,
        label: "Subject",
        focusNode: _subjectFocusNode,
        controller: _subjectController,
        validator: (value) {
          return subjectValidator(val: value, context: context);
        },
        keyboardType: TextInputType.text,
        onFieldSubmitted: (val) {
          setFocusNode(context: context, focusNode: _messageFocusNode);
        },
        inputAction: TextInputAction.next,
        icon: Icon(
          FontAwesomeIcons.info,
          size: 20,
        ));
  }

  get _getMessageField {
    return textFieldWidget(
        context: context,
        label: "Message",
        focusNode: _messageFocusNode,
        controller: _messageController,
        validator: (value) {
          return messageValidator(val: value, context: context);
        },
        keyboardType: TextInputType.multiline,
        inputAction: TextInputAction.done,
        icon: Icon(
          FontAwesomeIcons.stickyNote,
          size: 20,
        ));
  }

  Widget textFieldWidget({
    String label,
    Icon icon,
    @required TextEditingController controller,
    @required BuildContext context,
    @required FocusNode focusNode,
    TextInputAction inputAction,
    Function(String) onFieldSubmitted,
    TextInputType keyboardType,
    Function(String) validator,
  }) {
    return Theme(
      data: ThemeData(
        primaryColor: AppColors.kGreen,
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        cursorColor: AppColors.kGreen,
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: keyboardType,
        validator: validator,
        textInputAction: inputAction ?? TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: icon,
            hintText: label,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.kGreen),
                borderRadius: BorderRadius.all(Radius.circular(32)))),
      ),
    );
  }

  // Returns login button
  get _getSubmitButton {
    return getAppFlatButton(
      context: context,
      backGroundColor: AppColors.kGreen,
      titleText: "Submit",
      onPressed: () {
        closeKeyboard(context: context, onClose: () {});
        if (_formKey.currentState.validate()) {
          _contactUsApi();
        }
      },
    );
  }

  _contactUsApi() async {
    bool isConnected = await isConnectedToInternet();
    if (!isConnected ?? true) {
      getToast(msg: AppMessages.noInternetError);
      return;
    }
    _customLoader.showLoader(context);
    Map<String, dynamic> body = {
      "token": MemoryManagement.getAccessToken(),
      "name": _nameController.text.trim(),
      "email": _emailController.text.trim(),
      "phone": _phoneController.text.trim(),
      "subject": _subjectController.text.trim(),
      "message": _messageController.text.trim()
    };

    String url = "${ApiUrl.baseUrl}contact";
    print(url);
    var result = await http.post(url,
        headers: {"Accept": "application/json"}, body: body);
    getToast(msg: "Thank you! Your message has been successfully sent. ...");
    _customLoader.hideLoader();
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _subjectController.clear();
    _messageController.clear();
//    if (result.statusCode == 200) {
//      getToast(msg: "Query submitted successfully");
//      _customLoader.hideLoader();
//      _nameController.clear();
//      _emailController.clear();
//      _phoneController.clear();
//      _subjectController.clear();
//      _messageController.clear();
//      print("Response Body:${result.body}");
//    } else {
//      _customLoader.hideLoader();
//      getToast(msg: "Something went wrong");
//    }
  }
}
