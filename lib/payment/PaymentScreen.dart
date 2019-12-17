import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:vendor_flutter/Utils/AppColors.dart';
import 'package:vendor_flutter/Utils/Messages.dart';
import 'package:vendor_flutter/Utils/ReusableComponents/customLoader.dart';
import 'package:vendor_flutter/Utils/ReusableWidgets.dart';
import 'package:vendor_flutter/Utils/UniversalFunctions.dart';
import 'package:vendor_flutter/Utils/ValidatorFunctions.dart';
import 'package:vendor_flutter/Utils/memory_management.dart';
import 'package:vendor_flutter/data/PaymentResponse.dart';
import 'package:vendor_flutter/networks/api_urls.dart';

class PaymentTable extends StatefulWidget {
  @override
  _PaymentTableState createState() => _PaymentTableState();
}

class _PaymentTableState extends State<PaymentTable> {
  String transaction;
  PaymentResponse paymentResponse;
  final format = DateFormat("yyyy-MM-dd");
  DateTime selectedDate = DateTime.now();
  TextEditingController _dateFromController = TextEditingController();
  TextEditingController _dateToController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  CustomLoader _customLoader = CustomLoader();
  final GlobalKey<FormState> _addPaymentKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _getPayments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
                    children: <Widget>[
                      getSpacer(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Amount to be paid",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _showMsg(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "(This amount will be updated after admin approval)",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      getSpacer(height: 20),
                      _getDateRow(),
                      getSpacer(height: 20),
                      _getButtonRow(),
                      getSpacer(height: 20),
                      paymentResponse?.result?.isEmpty ?? true ? Center(
                          child: Padding(
                            child: Text("No Records Found",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),),
                            padding: const EdgeInsets.only(
                                top: 40, left: 10, right: 10),
                          )
                      )
                          : getCustomTable(
                        headers: [
                          'Total Amount',
                          'Type',
                          'Date',
                          'Status',
                          'Action',
                        ],
                        contentList:
                            List.generate(paymentResponse.result.length, (x) {
                          List<String> data = new List<String>();
                          data.add(
                              '${paymentResponse.result[x]?.amount ?? ""}');
                          data.add(
                              '${_getPaymentType(paymentResponse.result[x]?.amount) ?? ""}');
                          data.add(
                              '${paymentResponse.result[x]?.istDate ?? ""}');
                          data.add(
                              '${_getStatusTxt(paymentResponse.result[x]?.status) ?? ""}');
                          data.add('${showIconAccordingToStatus(
                              paymentResponse.result[x]?.status) ?? ""}');
                          return data;
                        }),
                      )
                    ],
                  )));
  }

  _getPayments() async {
    bool isConnected = await isConnectedToInternet();
    if (!isConnected ?? true) {
      _customLoader.hideLoader();
      showAlertDialog(
          context: context,
          title: "Error",
          message: AppMessages.noInternetError);
      return;
    }
    String url =
        "${ApiUrl.baseUrl}payment?token=${MemoryManagement.getAccessToken()}";
    print(url);
    final response =
        await http.get(url, headers: {"Accept": "application/json"});
    print(response.body);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      paymentResponse = PaymentResponse.fromJson(result);
      print("transaction length ${paymentResponse.result.length}");
      setState(() {});
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  static getCustomTable(
      {List<String> headers, List<List<String>> contentList: const []}) {
    int n = contentList.length + 1;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        defaultColumnWidth: FixedColumnWidth(150.0),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder(
          horizontalInside: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          verticalInside: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
        children: List.generate(n, (i) {
          if (i == 0) {
            return TableRow(
                decoration: BoxDecoration(color: Colors.blueGrey),
                children: List.generate(headers.length, (j) {
                  return getTableHeader(headers[j]);
                }));
          } else {
            return TableRow(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 0.4, color: Colors.black))),
              children: List.generate(
                contentList[i - 1].length,
                (j) {
                  printLog(contentList[i - 1][j]);
                  if (contentList[i - 1][j] == "no") {
                    return getTableCellWithIcon(FontAwesomeIcons.ban);
                  } else if (contentList[i - 1][j] == "edit") {
                    return getTableCellWithEdtDeleteIcon();
                  } else {
                    return getTableCell(contentList[i - 1][j]);
                  }
                },
              ),
            );
          }
        }),
      ),
    );
  }

//return table header (container with background color and text)
  static getTableHeader(String header) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: 80,
        child: Center(
            child: Text(
          header,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )));
  }

// return table cell (Container with transparent color and bottom border )
  static getTableCell(String value) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 5, right: 5),
        height: 55,
        child: Center(child: Text(value)));
  }

  static getTableCellWithIcon(IconData icon) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 5, right: 5),
        height: 55,
        child: Center(child: Icon(icon, color: Colors.red,)));
  }


  static getTableCellWithEdtDeleteIcon() {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 5, right: 5),
        height: 55,
        child: Center(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(FontAwesomeIcons.trashAlt, color: Colors.red,),
            getSpacer(width: 4),
            Icon(FontAwesomeIcons.penSquare, color: Colors.black54,),
          ],
        )));
  }

  String _getPaymentType(num amount) {
    if (amount > 0) {
      return "Given Money";
    } else {
      return "Take Money";
    }
  }

  String _getStatusTxt(int status) {
    if (status == 1) {
      return "Approved";
    } else {
      return "Approval\nPending";
    }
  }


  String showIconAccordingToStatus(int status) {
    if (status == 1) {
      return "no";
    } else {
      return "edit";
    }
  }

  String _showMsg() {
    num pending = paymentResponse != null ? paymentResponse.pending : 0;
    if (pending < 0) {
      pending *= -1;
      return "You have to receive $pending from Admin";
    } else if (pending > 0) {
      return "You have to pay $pending to Admin";
    } else {
      return "Balance is all clear";
    }
  }

  _getDateRow() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(width: 10.0,),
        new Flexible(
          child: GestureDetector(
            onTap: () => _selectDate(context, 1),
            child: AbsorbPointer(
              child: new TextField(
                  controller: _dateFromController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      labelText: "Date From",
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(6.0),
                        borderSide: new BorderSide(
                        ),
                      )
                  )
              ),
            ),
          ),
        ),
        SizedBox(width: 20.0,),
        new Flexible(
          child: GestureDetector(
            onTap: () => _selectDate(context, 2),
            child: AbsorbPointer(
              child: new TextField(
                  controller: _dateToController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: "Date to",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(6.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                  )
              ),
            ),
          ),
        ),
        SizedBox(width: 10.0,),
        IconButton(icon: Icon(
          FontAwesomeIcons.search,
          size: 25,
        ), onPressed: () {
          if (_dateFromController.text.isNotEmpty &&
              _dateToController.text.isNotEmpty) {
            _getPaymentsWithFilter();
          } else {
            showInSnackBar("Date from and date to should not be empty.");
          }
        },),
      ],
    );
  }


  Future<Null> _selectDate(BuildContext context, int i) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      selectedDate = picked;
    var formatDate = format.format(selectedDate.toLocal());
    if (i == 1) {
      _dateFromController.text = formatDate;
    } else {
      _dateToController.text = formatDate;
    }
    printLog(selectedDate.toLocal().toString());
    printLog(formatDate);
    setState(() {});
  }

  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }

  _getButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        getSpacer(width: 10),
        RaisedButton(
            child: new Text(
              "Reset", style: TextStyle(color: AppColors.kWhite),),
            onPressed: () {
              _dateFromController.clear();
              _dateToController.clear();
              _getPayments();
            },
            color: AppColors.kGreen,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(4),)
        ),
        getSpacer(width: 30),
        RaisedButton(
            child: new Text(
              "Add", style: TextStyle(color: AppColors.kWhite),),
            onPressed: () {
              _addPaymentBottomSheet(context);
              _descController.clear();
              _amountController.clear();
            },
            color: AppColors.kGreen,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(4),)
        ),
        getSpacer(width: 10),
      ],
    );
  }


  _getPaymentsWithFilter() async {
    _customLoader.showLoader(context);
    String url =
        "${ApiUrl.baseUrl}payment?token=${MemoryManagement
        .getAccessToken()}&date_from=${_dateFromController
        .text}&date_to=${_dateFromController.text}";

    print(url);
    final response =
    await http.get(url, headers: {"Accept": "application/json"});
    print(response.body);
    if (response.statusCode == 200) {
      _customLoader.hideLoader();
      var result = json.decode(response.body);
      paymentResponse = PaymentResponse.fromJson(result);
      print("transaction length ${paymentResponse.result.length}");
      setState(() {});
    } else {
      _customLoader.hideLoader();
      throw Exception('Failed to load transactions');
    }
  }


  _addPayment() async {
    bool isConnected = await isConnectedToInternet();
    if (!isConnected ?? true) {
      showAlertDialog(
          context: context,
          title: "Error",
          message: AppMessages.noInternetError);
      return;
    }
    _customLoader.showLoader(context);

    String url = "${ApiUrl.baseUrl}payment?token=${MemoryManagement
        .getAccessToken()}";

    print(url);
    Map<String, dynamic> body = {
      "amount": _amountController.text.trim(),
      "description": _descController.text.trim(),
      "status": "0"
    };

    final response =
    await http.post(url, headers: {"Accept": "application/json"}, body: body);
    print(response.statusCode);
    print(response.body);
    var result = jsonDecode(response.body);
    var msg = result["message"];
    if (response.statusCode == 200) {
      _customLoader.hideLoader();
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      _customLoader.hideLoader();
      showAlertDialog(
          context: context,
          title: "Error",
          message: msg);
    }
  }

  void _addPaymentBottomSheet(context) {
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
                        "Add Payment",
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
                getSpacer(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _addPaymentKey,
                      child: Column(children: <Widget>[
                        TextFormField(
                            controller: _amountController,
                            validator: (value) {
                              return amountValidator(amount: value);
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                labelText: "Amount",
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(6.0),
                                  borderSide: new BorderSide(
                                  ),
                                )
                            )
                        ),
                        getSpacer(height: 10),
                        TextFormField(
                            controller: _descController,
                            validator: (value) {
                              return amountDescValidator(desc: value);
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                labelText: "Payment Description",
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(6.0),
                                  borderSide: new BorderSide(
                                  ),
                                )
                            )
                        ),
                      ],),
                    ),
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
                            "Add", style: TextStyle(color: AppColors.kWhite),),
                          onPressed: () {
                            if (_addPaymentKey.currentState.validate()) {
                              _addPayment();
                              Navigator.of(context).pop();
                            }
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
