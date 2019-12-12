import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vendor_flutter/Utils/AppColors.dart';
import 'package:vendor_flutter/Utils/memory_management.dart';
import 'package:vendor_flutter/data/TransactionResponse.dart';
import 'package:vendor_flutter/networks/api_urls.dart';

class SimpleTable extends StatefulWidget {
  @override
  _SimpleTableState createState() => _SimpleTableState();
}

class _SimpleTableState extends State<SimpleTable> {
  bool toggle = true;
  String transaction;
  var transactionList = new List<TransactionResponse>();

  @override
  void initState() {
    super.initState();
    _getTransactions();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: transactionList.isEmpty ? Center(
              child: CircularProgressIndicator(),) : getCustomTable(
              headers: [
                'Customer Name',
                'Discount',
                'Net Payable Amount',
                'Admin share',
                'Payable to Admin',
                'Date'
              ],
              contentList: List.generate(transactionList.length, (x) {
                List<String> data = new List<String>();
                data.add('${transactionList[x]?.custName ?? ""}');
                data.add(
                    '${transactionList[x]?.discount ?? ""}');
                data.add('${transactionList[x]?.finalAmount ?? ""}');
                data.add('\$${transactionList[x]?.adminShare ?? ""}');
                data.add('\$${transactionList[x]?.adminAmount ?? ""}');
                data.add('${transactionList[x]?.istDate ?? ""}');
                return data;
              }),
            )
        )
    );
  }



  _getTransactions() async {
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

}