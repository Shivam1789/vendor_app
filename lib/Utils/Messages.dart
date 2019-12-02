class AppMessages {
  AppMessages._();

  // Errors
  static const String severNotFoundError = "Couldn't connect to the server.";
  static const String phNumberNotValidError = "Phone number not found.";
  static const String noInternetError =
      "Oops! Your internet is gone. Please check your internet connection";
  static const String timeoutError = "Request timeout";
  static const String generalError = "Something went wrong, please try again";
  static const String badFormatError = "Internal server error";
  static const String invalidLoginCredentials =
      "The Email or Password is incorrect.";
  static const String accountVerificationRequired =
      "This account has not been verified yet.";
  static const String invalidOTP = "Entered OTP is either invalid or expired.";
  static const String userNotFound = "User doesn't exist."
      ".";
  static const String paymentFailedError = "Payment failed.";
  static const String unauthorizedError = "Your session has expired, Please login again.";
  static const String unableToUpload = "Unable to upload image Please try again.";

  // Success messages
  static const String profileUpdateSuccess = "Profile updated successfully";
  static const String otpResend = "OTP has resent to your Registered Mobile Number";

  // Question messages
  static const String unableToLoadData = "Unalbe to Laod Data";
  static const String unableToLocate = "Unable to get Location Please Try Again ";
  static const String needCameraAccess = "Need to Allow Camera access to apply for loan";
  static const String routeToSetting = "Pro Pawn app is not authorized to use camera."
      "Please enable camera permission from settings."
  ;

  //retry

  //warnings
  static const String removePhoto = "Are you sure you want to remove selected photo";

}
