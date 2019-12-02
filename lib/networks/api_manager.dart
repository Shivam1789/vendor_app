
import 'package:flutter/material.dart';

import 'api_handler.dart';
import 'api_urls.dart';

class ApiManager {
  /*
  Login method 
   */
  static Future<Map<String, dynamic>> login({context,
    @required Map<String, String> header,
    @required Map<String, dynamic> body}) async {
    return await ApiHandler.hit(context: context,
        url: ApiUrl.login,
        type: apiType.post,
        header: header,
        body: body);
  }

  //Logout
  static Future<Map<String, dynamic>> logout({context,
    @required Map<String, String> header,
    @required Map<String, dynamic> body}) async {
    return await ApiHandler.hit(context: context,
        url: ApiUrl.logout,
        type: apiType.get,
        header: header,
        body: body);
  }  //Signup
  static Future<Map<String, dynamic>> signUp({context,
    @required Map<String, String> header,
    @required Map<String, dynamic> body}) async {
    return await ApiHandler.hit(context: context,
        url: ApiUrl.signUp,
        type: apiType.post,
        header: header,
        body: body);
  }
  //verifyOtp
  static Future<Map<String, dynamic>> verifyOtp({context,
    @required Map<String, String> header,
    @required Map<String, dynamic> body}) async {
    return await ApiHandler.hit(context: context,
        url: ApiUrl.verifyOtp,
        type: apiType.put,
        header: header,
        body: body);
  }
  //verifyEditProfileOtp
  static Future<Map<String, dynamic>> verifyEditProfileOtp({context,
    @required Map<String, String> header,
    @required Map<String, dynamic> body}) async {
    return await ApiHandler.hit(context: context,
        url: ApiUrl.verifyEditProfilePhone,
        type: apiType.put,
        header: header,
        body: body);
  }
  //GetLoanList
  static Future<Map<String, dynamic>> getLoanList({context,
    @required Map<String, String> header,
    @required Map<String, dynamic> body,pageNumber:1}) async {
    return await ApiHandler.hit(context: context,
        url: ApiUrl.getMyLoanREQList+"/$pageNumber",
        type: apiType.get,
        header: header,
        body: body);
  }
  //getReadyToChat List
  static Future<Map<String, dynamic>> getReadyToChatList({context,
    @required Map<String, String> header,
    @required Map<String, dynamic> body,pageNumber:1}) async {
    return await ApiHandler.hit(context: context,
        url: ApiUrl.getReadyToChatList+"?page=$pageNumber",
        type: apiType.get,
        header: header,
        body: body);
  }
  //search List
  static Future<Map<String, dynamic>> searchChatByLoan({context,
    @required Map<String, String> header,
    @required Map<String, dynamic> body,pageNumber:1,text:""}) async {
    return await ApiHandler.hit(context: context,
        url: ApiUrl.getReadyToChatList+"?page=${pageNumber}&search=$text",
        type: apiType.get,
        header: header,
        body: body);
  }
  //GetLoanList
  static Future<Map<String, dynamic>> editProfile({context,
    @required Map<String, String> header,
    @required Map<String, dynamic> body}) async {
    return await ApiHandler.hit(context: context,
        url: ApiUrl.editProfile,
        type: apiType.put,
        header: header,
        body: body);
  }

  //add loan
  static Future<Map<String, dynamic>> requestLoan({context,
    @required Map<String, String> header,
    @required Map<String, dynamic> body}) async {
    return await ApiHandler.hit(context: context,
        url: ApiUrl.addLoanRequest,
        type: apiType.post,
        header: header,
        body: body);
  }
  //add loan
  static Future<Map<String, dynamic>> getFAQList({context,
    @required Map<String, String> header,
    @required Map<String, dynamic> body}) async {
    return await ApiHandler.hit(context: context,
        url: ApiUrl.faq,
        type: apiType.get,
        header: header,
        body: body);
  }
  static Future<Map<String, dynamic>> getLocation({context,
    @required Map<String, String> header,
    @required Map<String, dynamic> body}) async {
    return await ApiHandler.hit(context: context,
        url: ApiUrl.locateUs,
        type: apiType.get,
        header: header,
        body: body);
  }
  static Future<Map<String, dynamic>> onMessageSend({context,
    @required Map<String, String> header,
    @required Map<String, dynamic> body}) async {
    return await ApiHandler.hit(context: context,
        url: ApiUrl.onSend,
        type: apiType.post,
        header: header,
        body: body);
  }
}