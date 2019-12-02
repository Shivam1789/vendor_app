import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vendor_flutter/Utils/AppColors.dart';
import 'package:vendor_flutter/Utils/ReusableWidgets.dart';
import 'package:vendor_flutter/Utils/UniversalFunctions.dart';

class CreateSales extends StatefulWidget {
  @override
  _CreateSalesState createState() => _CreateSalesState();
}

class _CreateSalesState extends State<CreateSales> {
  final FocusNode _nameFocusNode = new FocusNode();
  final GlobalKey<FormState> _signUpFormKey = new GlobalKey<FormState>();
  bool switchOn = false;

  void _onSwitchChanged(bool value) {
    switchOn = value;
    setState(() {});
  }

  // Returns sign up label
  get _getSignUpLabel {
    return new Align(
      alignment: Alignment.center,
      child: new Text(
        "Create Sales",
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        getAppThemedBGOne(),
        Scaffold(
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
                                getSpacer(
                                  height:
                                      getScreenSize(context: context).height *
                                          0.07,
                                ),
                                _getSignUpLabel,
                                getSpacer(
                                  height:
                                      getScreenSize(context: context).height *
                                          0.1,
                                ),
                                _getNameField,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Check Point",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: AppColors.kGreen),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                getSpacer(
                                  height:
                                      getScreenSize(context: context).height *
                                          0.02,
                                ),
                                _getAmount,
                                getSpacer(
                                  height:
                                      getScreenSize(context: context).height *
                                          0.02,
                                ),
                                _getSales,
                                getSpacer(
                                  height:
                                      getScreenSize(context: context).height *
                                          0.02,
                                ),
                                _getAvailablePoint(),
                                getSpacer(
                                  height:
                                      getScreenSize(context: context).height *
                                          0.02,
                                ),
                                _getSignUpButton,
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                )))
      ],
    );
  }

  // Returns name field
  get _getNameField {
    return textFieldWidget(
        context: context,
        label: "Custom Code",
        focusNode: _nameFocusNode,
        icon: Icon(
          FontAwesomeIcons.qrcode,
          size: 20,
        ));
//    return appThemedTextFieldTwo(
//      context: context,
//      label: "Custom Code",
////      controller: _signUpBloc.nameController,
////      focusNode: _nameFocusNode,
//      validator: (value) {
////        return emailPhoneValidator(email: value, context: context);
//      },
////      onFieldSubmitted: (val) {
////        setFocusNode(context: context, focusNode: _nameFocusNode);
////      },
//      maxLength: 45,
//      textCapitalization: TextCapitalization.words,
//      prefix: Icon(
//        FontAwesomeIcons.qrcode,
//        size: 20,
//      ),
//    );
  }

  get _getAmount {
    return textFieldWidget(
        context: context,
        label: "Amount",
        focusNode: _nameFocusNode,
        icon: Icon(
          FontAwesomeIcons.sortAmountUp,
          size: 20,
        ));

    /*return appThemedTextFieldTwo(
      context: context,
      label: "Amount",
//      controller: _signUpBloc.nameController,
//      focusNode: _nameFocusNode,
      validator: (value) {
//        return emailPhoneValidator(email: value, context: context);
      },
//      onFieldSubmitted: (val) {
//        setFocusNode(context: context, focusNode: _nameFocusNode);
//      },
      maxLength: 45,
      textCapitalization: TextCapitalization.words,
      prefix: Icon(
        FontAwesomeIcons.sortAmountUp,
        size: 20,
      ),
    );*/
  }

  get _getSales {
    return textFieldWidget(
        context: context,
        label: "Sales Description",
        focusNode: _nameFocusNode,
        icon: Icon(
          FontAwesomeIcons.envelopeOpenText,
          size: 20,
        ));

/*    return appThemedTextFieldTwo(
      context: context,
      label: "Sales Description",
//      controller: _signUpBloc.nameController,
//      focusNode: _nameFocusNode,
      validator: (value) {
//        return emailPhoneValidator(email: value, context: context);
      },
//      onFieldSubmitted: (val) {
//        setFocusNode(context: context, focusNode: _nameFocusNode);
//      },
      maxLength: 45,
      textCapitalization: TextCapitalization.words,
      prefix: Icon(
        FontAwesomeIcons.envelopeOpenText,
        size: 20,
      ),
      maxLines: 8,
      keyboardType: TextInputType.multiline,
      inputAction: TextInputAction.newline,
    );*/
  }

  // Returns login button
  get _getSignUpButton {
    return getAppFlatButton(
      context: context,
      backGroundColor: AppColors.kGreen,
      titleText: "CREATE SALES",
      onPressed: () {
        closeKeyboard(context: context, onClose: () {});
//        if (_signUpFormKey.currentState.validate()) {}
      },
    );
  }

  Widget _getAvailablePoint() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Use Available Point",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: AppColors.kGreen),
            ),
            Switch(
              onChanged: _onSwitchChanged,
              value: switchOn,
            ),
          ],
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }

  Widget textFieldWidget({
    String label,
    Icon icon,
    @required TextEditingController controller,
    @required BuildContext context,
    @required FocusNode focusNode,
  }) {
    return Theme(
      data: ThemeData(
        primaryColor: AppColors.kGreen,
      ),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.black, height: 0.5),
        cursorColor: AppColors.kGreen,
        decoration: InputDecoration(
            prefixIcon: icon,
            hintText: label,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.kGreen),
                borderRadius: BorderRadius.all(Radius.circular(32)))),
      ),
    );
  }
}
