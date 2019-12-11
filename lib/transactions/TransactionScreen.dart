import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_table/json_table.dart';
import 'package:vendor_flutter/Utils/memory_management.dart';
import 'package:vendor_flutter/networks/api_urls.dart';

class SimpleTable extends StatefulWidget {
  @override
  _SimpleTableState createState() => _SimpleTableState();
}

class _SimpleTableState extends State<SimpleTable> {
  final String jsonSample =
      '[{"name":"Ram","email":"ram@gmail.com","age":23,"income":"10Rs","country":"India","area":"abc"},{"name":"Shyam","email":"shyam23@gmail.com",'
      '"age":28,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"John","email":"john@gmail.com","age":33,"income":"15Rs","country":"India",'
      '"area":"abc","day":"Monday","month":"april"},{"name":"Ram","email":"ram@gmail.com","age":23,"income":"10Rs","country":"India","area":"abc","day":"Monday","month":"april"},'
      '{"name":"Shyam","email":"shyam23@gmail.com","age":28,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"John","email":"john@gmail.com",'
      '"age":33,"income":"15Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"Ram","email":"ram@gmail.com","age":23,"income":"10Rs","country":"India",'
      '"area":"abc","day":"Monday","month":"april"},{"name":"Shyam","email":"shyam23@gmail.com","age":28,"income":"30Rs","country":"India","area":"abc","day":"Monday","month":"april"},'
      '{"name":"John","email":"john@gmail.com","age":33,"income":"15Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"Ram","email":"ram@gmail.com","age":23,'
      '"income":"10Rs","country":"India","area":"abc","day":"Monday","month":"april"},{"name":"Shyam","email":"shyam23@gmail.com","age":28,"income":"30Rs","country":"India","area":"abc",'
      '"day":"Monday","month":"april"},{"name":"John","email":"john@gmail.com","age":33,"income":"15Rs","country":"India","area":"abc","day":"Monday","month":"april"}]';
  bool toggle = true;
  String transaction;

  @override
  void initState() {
    super.initState();
    _getTransactions();
  }
  @override
  Widget build(BuildContext context) {
    var json = jsonDecode(transaction != null ? transaction : jsonSample);
    print(json);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: toggle
            ? Column(
          children: [
            JsonTable(
              json,
              showColumnToggle: false,
              tableHeaderBuilder: (String header) {
                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5),
                      color: Colors.grey[300]),
                  child: Text(
                    header,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.display1.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                        color: Colors.black87),
                  ),
                );
              },
              tableCellBuilder: (value) {
                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 2.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.5,
                          color: Colors.grey.withOpacity(0.5))),
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.display1.copyWith(
                        fontSize: 16.0, color: Colors.grey[900]),
                  ),
                );
              },
              allowRowHighlight: true,
              rowHighlightColor: Colors.yellow[500].withOpacity(0.7),
              paginationRowCount: 10,
            ),
          ],
        )
            : Center(
          child: Text(getPrettyJSONString(jsonSample)),
        ),
      ),
    );
  }

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }


  _getTransactions() async {
    String url = "${ApiUrl.baseUrl}transaction?token=${MemoryManagement
        .getAccessToken()}";
    print(url);
    final response =
    await http.get(url, headers: {"Accept": "application/json"});
    print(response.body);
    if (response.statusCode == 200) {
      transaction = response.body;
      setState(() {

      });
    } else {
      throw Exception('Failed to load transactions');
    }
  }
}