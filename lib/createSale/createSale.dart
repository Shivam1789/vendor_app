import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:vendor_flutter/Utils/AppColors.dart';
import 'package:vendor_flutter/Utils/AssetStrings.dart';
import 'package:vendor_flutter/Utils/Messages.dart';
import 'package:vendor_flutter/Utils/ReusableComponents/customLoader.dart';
import 'package:vendor_flutter/Utils/ReusableWidgets.dart';
import 'package:vendor_flutter/Utils/UniversalFunctions.dart';
import 'package:vendor_flutter/Utils/ValidatorFunctions.dart';
import 'package:vendor_flutter/Utils/memory_management.dart';
import 'package:vendor_flutter/data/SalesResponse.dart';
import 'package:vendor_flutter/networks/api_urls.dart';

class CreateSales extends StatefulWidget {
  @override
  _CreateSalesState createState() => _CreateSalesState();
}

class _CreateSalesState extends State<CreateSales> {
  final TextEditingController _codeController = new TextEditingController();
  final TextEditingController _amountController = new TextEditingController();
  final TextEditingController _descController = new TextEditingController();

  final FocusNode _codeFocusNode = new FocusNode();
  final FocusNode _amountFocusNode = new FocusNode();
  final FocusNode _descFocusNode = new FocusNode();
  final GlobalKey<FormState> _FormKey = new GlobalKey<FormState>();
  SalesResponse salesResponse;
  bool switchOn = true;
  String _availablePoints = "";
  CustomLoader _customLoader = CustomLoader();
  String _barcodeString;

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

  _scanBarcode() async {
    _barcodeString = await QRCodeReader()
        .setAutoFocusIntervalInMs(200)
        .setForceAutoFocus(true)
        .setTorchEnabled(true)
        .setHandlePermissions(true)
        .setExecuteAfterPermissionGranted(true)
        .scan();

    if (_barcodeString != null && _barcodeString.contains("cust_id\$")) {
      print(_barcodeString);
      final startIndex = _barcodeString.indexOf("\$");
      _codeController.text =
          _barcodeString.substring(startIndex + 1, _barcodeString.length);
    }
  }

  get _getScanCode {
    return InkWell(
      onTap: () async {
        _scanBarcode();
      },
      child: new Text(
        "Click here to scan Customer QR or enter Customer code info below.",
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
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
                      key: _FormKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: new SingleChildScrollView(
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
                                      height: 20
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _scanBarcode();
                                    },
                                    child: new Image.asset(
                                      AssetStrings.barcode,
                                      fit: BoxFit.fill,
                                      height: getScreenSize(context: context)
                                          .width * 0.21,
                                      width: getScreenSize(context: context)
                                          .width * 0.28,
                                    ),
                                  ),
                                  _getScanCode,
                                  getSpacer(
                                      height: 20
                                  ),
                                  _getNameField,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      _availablePoints
                                          .isNotEmpty ? Text(
                                        "Available points:$_availablePoints",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.green),
                                      ) : Container(),
                                      InkWell(
                                        onTap: () {
                                          if (_codeController.text
                                              .trim()
                                              .isNotEmpty) {
                                            _checkCode();
                                          } else {
                                            showAlertDialog(
                                                context: context,
                                                title: "Error",
                                                message: "Customer code canot be empty");
                                          }
                                        },
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
                                  getSpacer(
                                    height:
                                    getScreenSize(context: context).height *
                                        0.02,
                                  )
                                ],
                              ),
                            ],
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
        focusNode: _codeFocusNode,
        controller: _codeController,
        validator: (value) {
          return codEmpty(
              code: value, context: context);
        },
        keyboardType: TextInputType.phone,
        onFieldSubmitted: (val) {
          setFocusNode(context: context, focusNode: _amountFocusNode);
        },
        inputAction: TextInputAction.next,
        icon: Icon(
          FontAwesomeIcons.qrcode,
          size: 20,
        ));
  }

  get _getAmount {
    return textFieldWidget(
        context: context,
        label: "Amount",
        validator: (value) {
          return amountEmpty(
              code: value, context: context);
        },
        focusNode: _amountFocusNode,
        controller: _amountController,
        keyboardType: TextInputType.phone,
        onFieldSubmitted: (val) {
          setFocusNode(context: context, focusNode: _descFocusNode);
        },
        inputAction: TextInputAction.next,
        icon: Icon(
          FontAwesomeIcons.moneyBill,
          size: 20,
        ));
  }

  get _getSales {
    return textFieldWidget(
        context: context,
        label: "Sales Description",
        focusNode: _descFocusNode,
        controller: _descController,
        validator: (value) {
          return descEmpty(
              code: value, context: context);
        },
        keyboardType: TextInputType.text,
        inputAction: TextInputAction.done,
        icon: Icon(
          FontAwesomeIcons.fileMedical,
          size: 20,
        ));
  }

  // Returns login button
  get _getSignUpButton {
    return getAppFlatButton(
      context: context,
      backGroundColor: AppColors.kGreen,
      titleText: "CREATE SALES",
      onPressed: () {
        closeKeyboard(context: context, onClose: () {});
        if (_FormKey.currentState.validate()) {
          _salesDetail();
        }
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


  _checkCode() async {
    bool isConnected = await isConnectedToInternet();
    if (!isConnected ?? true) {
      getToast(msg: AppMessages.noInternetError);
      return;
    }
    _customLoader.showLoader(context);
    String url = "${ApiUrl.baseUrl}customer/point?code=${_codeController.text
        .trim()} ";
    print(url);
    var result =
    await http.get(url, headers: {"Accept": "application/json"});
    if (result.statusCode == 200) {
      _customLoader.hideLoader();
      print("Response Body:${result.body}");
      var response = jsonDecode(result.body);
      _availablePoints = response["data"];
      setState(() {

      });
    } else {
      _customLoader.hideLoader();
      getToast(msg: "Customer code is invalid");
    }
  }

  _createSales() async {
    bool isConnected = await isConnectedToInternet();
    if (!isConnected ?? true) {
      getToast(msg: AppMessages.noInternetError);
      return;
    }
    _customLoader.showLoader(context);
    var switchVal = switchOn ? 1 : 0;

    String url = "${ApiUrl.baseUrl}sale";
    print(url);
    Map<String, dynamic> body = {
      "token": MemoryManagement.getAccessToken(),
      "code": _codeController.text.trim(),
      "amount": _amountController.text.trim(),
      "description": _descController.text.trim(),
      "pt_flag": "$switchVal"
    };

    final response =
    await http.post(url, headers: {"Accept": "application/json"}, body: body);
    print(response.statusCode);
    print(response.body);
    var result = jsonDecode(response.body);
    var msg = result["message"];
    if (response.statusCode == 200) {
      _amountController.clear();
      _codeController.clear();
      _descController.clear();
      _customLoader.hideLoader();
      getToast(msg: msg);
      setState(() {
      });
    } else {
      _customLoader.hideLoader();
      getToast(msg: msg);
    }
  }

  Widget dialogTile({String txt, String value}) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(txt,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,),
          Text(value,
            style: TextStyle(color: Colors.black), overflow: TextOverflow.
            ellipsis, maxLines: 1,)
        ],),
    );
  }


  _salesDetail() async {
    bool isConnected = await isConnectedToInternet();
    if (!isConnected ?? true) {
      getToast(msg: AppMessages.noInternetError);
      return;
    }
    _customLoader.showLoader(context);
    var switchVal = switchOn ? 1 : 0;
    String url = "${ApiUrl.baseUrl}sale?token=${MemoryManagement
        .getAccessToken()}&code=${_codeController
        .text}&amount=${_amountController.text}&description=${_descController
        .text}&pt_flag=$switchVal ";
    print(url);
    var result =
    await http.get(url, headers: {"Accept": "application/json"});
    if (result.statusCode == 200) {
      _customLoader.hideLoader();
      print("Response Body:${result.body}");
      final response = json.decode(result.body);
      salesResponse = SalesResponse.fromJson(response);
      print(salesResponse.data);

//      showCustomDialog(context);
      _settingModalBottomSheet(context);
    } else {
      _customLoader.hideLoader();
      getToast(msg: "Something went wrong");
    }
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.grey[300]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      getSpacer(height: 0),
                      Text(
                        "Sale Detail",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      IconButton(
                        icon: Icon(
                          FontAwesomeIcons.times, color: AppColors.kGreen,),
                        onPressed: () {
                          Navigator.pop(context);
                        },)
                    ],
                  ),
                ),
                getSpacer(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      dialogTile(txt: "Customer Name:",
                          value: salesResponse.data.user.name ?? ""),
                      dialogTile(
                          txt: "Total Bill:",
                          value: salesResponse.data.amount.toString()),
                      dialogTile(
                          txt: "Point Redeemed:",
                          value: salesResponse.data.disc.toString()),
                      dialogTile(txt: "Payable Amount:",
                          value: salesResponse.data.finalAmount.toString()),
                      dialogTile(
                          txt: "Point(s) earned:",
                          value: salesResponse.data.points.toString()),
                    ],),
                  ),
                ),
                getSpacer(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 140,
                      height: 40,
                      child: RaisedButton(
                          child: new Text(
                            "Paid", style: TextStyle(color: AppColors.kWhite),),
                          onPressed: () {
                            _createSales();
                            Navigator.of(context).pop();
                          },
                          color: AppColors.kGreen,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(4),)
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
    );
  }
}
