import 'package:vendor_flutter/Utils/memory_management.dart';

class ApiUrl {
  //  local Url

//  static const String baseUrl = "http://182.75.105.186:3031/v1/";

  //  !QA URL

  //  Live

  static const String baseUrl = "http://gk3.puneetchawla.in/api/v1/";

  //  system

  //    static const String baseUrl = "http://192.168.0.242:8083/v1/";

  //Auth
  static const String signUp = "$baseUrl" + "signup";
  static const String verifyOtp = "$baseUrl" + "otp_verify";
  static const String userExist = "$baseUrl" + "username";
  static const String login = "$baseUrl" + "login";
  static const String logout = "$baseUrl" + "users/logout";

  //user
  static const String editProfile = "$baseUrl" + "users";
  static const String verifyEditProfilePhone = "$baseUrl" + "users/otp_verify";

  //Loan
  static const String addLoanRequest = "$baseUrl" + "loan";
  static const String getMyLoanREQList = "$baseUrl" + "image";
  static const String getReadyToChatList = "$baseUrl" + "loan/chat";

  //CMS

  static const String aboutUs = "$baseUrl" + "cms/aboutUS";
  static const String privacyPolicy = "$baseUrl" + "cms/privacy_policy";
  static const String termsAndConditions = "$baseUrl" + "cms/termsConditions";
  static const String faq = "$baseUrl" + "cms/faqs";
  static const String locateUs = "$baseUrl" + "cms/locateUs";

  //chat

  static const String onSend = "$baseUrl" + "chat";
}
