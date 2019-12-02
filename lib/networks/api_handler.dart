import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vendor_flutter/Utils/Messages.dart';
import 'package:vendor_flutter/Utils/ReusableComponents/customLoader.dart';
import 'package:vendor_flutter/Utils/UniversalFunctions.dart';
import 'dart:async';

import 'package:vendor_flutter/Utils/memory_management.dart';

import 'NetworkError.dart';


enum apiType { get, post, put } //delete,option,head,connect ,trace

class ApiHandler {
  static final Duration _timeoutDuration = Duration(seconds: 30);

  static Future<Map<String, String>> getHeader() async {
    Map<String, String> map = {
      "Content-Type": "application/json",
      "device_id": "1234678",
      "device_type": "1",
      "app_version": "1.0",
      "Token": await MemoryManagement.getAccessToken() ?? "",
    };
    return map;
  }

  static hit(
      {BuildContext context,
      @required String url,
      @required apiType type,
      Map<String, String> header,
      dynamic body}) async {
    Map<String, String> commonHeader = await getHeader();

    print("header: $commonHeader");
    var jsonBody = json.encode(body);
    print('body : $body');
    print('Json body : $jsonBody');

    http.Response response;
    print("Url $url Type ${type.toString()}");

    try {
      switch (type) {
        case apiType.get:
          response =
              await http.get(url, headers: commonHeader).timeout(_timeoutDuration);
          break;
        case apiType.put:
          response = await http
              .put(url, headers: commonHeader, body: jsonBody)
              .timeout(_timeoutDuration);
          break;
        case apiType.post:
          response = await http
              .post(url, headers: commonHeader, body: jsonBody)
              .timeout(_timeoutDuration);
          break;
      }
    } on TimeoutException {
      print("Connection Timeout ");
      return NetworkError(status: "0", message: AppMessages.timeoutError).toJson();
    } catch (e) {
      print("Exceptioin ::$e");
      return NetworkError(status: "0", message: AppMessages.generalError).toJson();
    }
    print("Response Code: ${response.statusCode}");
    print("Response Body:${response.body}");

    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
        break;
      case 400:
        return jsonDecode(response.body);
        break;
      case 404:
        return NetworkError(status: "0", message: "Page not found ").toJson();
        break;
      case 401:
        print("401");
        print("logged out $context");
        CustomLoader cl = new CustomLoader();
        cl.hideLoader();
        await showAlertDialog(
            context: context,
            title: "Error",
            message: AppMessages.unauthorizedError);
//        await logout(context);
        break;
      default:
        return NetworkError(status: "0", message: AppMessages.generalError)
            .toJson();
    }
  }
}
