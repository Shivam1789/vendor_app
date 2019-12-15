import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:vendor_flutter/Utils/AppColors.dart';
import 'package:vendor_flutter/Utils/Messages.dart';
import 'package:vendor_flutter/Utils/ReusableComponents/customLoader.dart';
import 'package:vendor_flutter/Utils/ReusableWidgets.dart';
import 'package:vendor_flutter/Utils/UniversalFunctions.dart';
import 'package:vendor_flutter/Utils/memory_management.dart';
import 'package:vendor_flutter/data/TransactionResponse.dart';
import 'package:vendor_flutter/networks/api_urls.dart';

class TransactionTable extends StatefulWidget {
  @override
  _TransactionTableState createState() => _TransactionTableState();
}

class _TransactionTableState extends State<TransactionTable> {
  bool toggle = true;
  String transaction;
  var transactionList = new List<TransactionResponse>();
  final format = DateFormat("yyyy-MM-dd");
  DateTime selectedDate = DateTime.now();
  TextEditingController _dateFromController = TextEditingController();
  TextEditingController _dateToController = TextEditingController();
  CustomLoader _customLoader = CustomLoader();
  @override
  void initState() {
    super.initState();
    _getTransactions();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
              getSpacer(height: 20),
              _getDateRow(),
              getSpacer(height: 20),
              transactionList.isEmpty ? Center(
                  child: Padding(
                    child: Text("No Records Found",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),),
                    padding: const EdgeInsets.only(
                        top: 40, left: 10, right: 10),
                  )
              ) : getCustomTable(
                headers: [
                  'Customer Name',
                  'Total Amount',
                  'Discount',
                  'Net Payable Amount',
                  'Admin share',
                  'Payable to Admin',
                  'Date'
                ],
                contentList: List.generate(transactionList.length, (x) {
                  List<String> data = new List<String>();
                  data.add('${transactionList[x]?.custName ?? ""}');
                  data.add('${transactionList[x]?.amount.toString() ?? ""}');
                  data.add(
                      '${transactionList[x]?.discount ?? ""}');
                  data.add('${transactionList[x]?.finalAmount ?? ""}');
                  data.add('${transactionList[x]?.adminAmount ?? ""}');
                  data.add('${transactionList[x]?.adminShare ?? ""}');
                  data.add('${transactionList[x]?.istDate ?? ""}');
                  return data;
                }),
              )
            ],)
        )
    );
  }


  String _convertToLocal({String date}) {
    DateFormat format = new DateFormat("yyyy-MM-dd hh:mm");
    DateTime time = format.parse(date);
    return time.toLocal().toString();
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
                decoration:
                BoxDecoration(color: Colors.blueGrey),
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
                  return getTableCell(contentList[i - 1][j]);
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
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )));
  }

// return table cell (Container with transparent color and bottom border )
  static getTableCell(String value) {
    return Container(alignment: Alignment.center,
        padding: EdgeInsets.only(left: 5, right: 5),
        height: 55,
        child: Center(child: Text(value)));
  }

  _getTransactions() async {
    bool isConnected = await isConnectedToInternet();
    if (!isConnected ?? true) {
      _customLoader.hideLoader();
      showAlertDialog(
          context: context,
          title: "Error",
          message: AppMessages.noInternetError);
      return;
    }
    String url = "${ApiUrl.baseUrl}transaction?token=${MemoryManagement
        .getAccessToken()}";
    print(url);
    final response =
    await http.get(url, headers: {"Accept": "application/json"});
    print(response.body);
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      transactionList =
          list.map((model) => TransactionResponse.fromJson(model)).toList();
      print("transaction length ${transactionList.length}");
      transaction = response.body;
      setState(() {

      });
    } else {
      throw Exception('Failed to load transactions');
    }
  }


  _getTransactionsWithFilter() async {
    _customLoader.showLoader(context);
    String url =
        "${ApiUrl.baseUrl}transaction?token=${MemoryManagement
        .getAccessToken()}&date_from=${_dateFromController
        .text}&date_to=${_dateFromController.text}";

    print(url);
    final response =
    await http.get(url, headers: {"Accept": "application/json"});
    print(response.body);
    if (response.statusCode == 200) {
      _customLoader.hideLoader();
      Iterable list = json.decode(response.body);
      transactionList =
          list.map((model) => TransactionResponse.fromJson(model)).toList();
      print("transaction length ${transactionList.length}");
      transaction = response.body;
      setState(() {

      });
    } else {
      _customLoader.hideLoader();
      throw Exception('Failed to load transactions');
    }
  }

  _getDateRow() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(width: 4.0,),
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
        SizedBox(width: 10.0,),
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
        SizedBox(width: 4.0,),
        IconButton(icon: Icon(
          FontAwesomeIcons.search,
          size: 25,
        ), onPressed: () {
          if (_dateFromController.text.isNotEmpty &&
              _dateToController.text.isNotEmpty) {
            _getTransactionsWithFilter();
          } else {
            showInSnackBar("Date from and date to should not be empty.");
          }
        },),

        IconButton(icon: Icon(
          FontAwesomeIcons.redo,
          size: 25,
        ), onPressed: () {
          _dateFromController.clear();
          _dateToController.clear();
          _getTransactions();
        },),
        SizedBox(width: 4.0,),
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
}