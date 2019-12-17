// Validates email format
import 'package:flutter/cupertino.dart';

import 'Localization.dart';
import 'LocalizationValues.dart';

bool isEmailFormatValid(String email) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(email);
}

// Validates email field
String emailValidator(
    {@required String email, @required BuildContext context}) {
  if (email.trim().isEmpty) {
    return "Please enter email";
  } else if (!isEmailFormatValid(email.trim())) {
    return "Enter valid email";
  }
  return null;
}

String amountDescValidator(
    {@required String desc}) {
  if (desc.trim().isEmpty) {
    return "The description field is required.";
  }
  return null;
}

String amountValidator(
    {@required String amount}) {
  if (amount.trim().isEmpty) {
    return "The amount field is required.";
  }
  return null;
}

// Validates qrCode field
String qrCodeValidator(
    {@required String reason, @required BuildContext context}) {
  if (reason.trim().isEmpty) {
    return Localization.of(context).trans(LocalizationValues.pleaseEnterQRCode);
  }
  return null;
}

// Validates profile picture field
String profilePictureValidator({
  @required String profilePicturePath,
  @required BuildContext context,
}) {
  if (profilePicturePath.trim().isEmpty) {
    return Localization.of(context)
        .trans(LocalizationValues.selectProfilePicture);
  }
  return null;
}

// Validates region field
String regionValidator({
  @required String region,
  @required BuildContext context,
}) {
  if (region.trim().isEmpty) {
    return Localization.of(context)
        .trans(LocalizationValues.pleaseSelectRegion);
  }
  return null;
}

// Validates dropDown field
String dropDownValidator({
  @required String value,
  @required BuildContext context,
  @required String label,
}) {
  if (value.trim().toUpperCase() ==
      Localization.of(context).trans(LocalizationValues.select).toUpperCase()) {
    return Localization.of(context).trans(LocalizationValues.pleaseSelect) +
        " $label.";
  }
  return null;
}

// Validates email/Phone field
String emailPhoneValidator(
    {@required String email, @required BuildContext context}) {
  if (email.trim().isEmpty) {
    return "Please enter email";
  } else if (!isEmailFormatValid(email.trim())) {
    return "Please enter valid email";
  }
  return null;
}

// Validates phone number field
String phoneNumberValidator(
    {@required String phoneNumber, @required BuildContext context}) {
  if (phoneNumber.trim().isEmpty) {
    return "Please enter Phone No.";
  } else if (!isNameLengthValid(phoneNumber.trim())) {
    return "Please enter phone no. between 6-15 characters.";
  }
  return null;
}

// Validated "entered password" field
String enteredPasswordValidator(
    {@required String enteredPassword, @required BuildContext context}) {
  if (enteredPassword.isEmpty) {
    return "Please enter password";
  }
  return null;
}

// Validates password format
bool isPasswordLengthValid(String password) {
  if (password.length >= 8 && password.length <= 16) {
    return true;
  }
  return false;
}

// Validates password complexity
bool isPasswordComplexEnough(String password) {
  String p = r"^(?=(.*[0-9]))(?=(.*[A-Za-z]))";
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(password);
}

// Validates "new password" field
String passwordValidator(
    {@required String newPassword, @required BuildContext context}) {
  if (newPassword.isEmpty) {
    return "Please enter password";
  }
  return null;
}

String codEmpty(
    {@required String code, @required BuildContext context}) {
  if (code.isEmpty) {
    return "Please enter customer code.";
  }
  return null;
}

String amountEmpty(
    {@required String code, @required BuildContext context}) {
  if (code.isEmpty) {
    return "Please enter amount.";
  }
  return null;
}

String descEmpty(
    {@required String code, @required BuildContext context}) {
  if (code.isEmpty) {
    return "Please enter description.";
  }
  return null;
}

// Validates "new password" field
String newPasswordValidator(
    {@required String newPassword, @required BuildContext context}) {
  if (newPassword.isEmpty) {
    return Localization.of(context).trans(LocalizationValues.enterPwd);
  } else if (!isPasswordLengthValid(newPassword)) {
    return Localization.of(context).trans(LocalizationValues.enterPwdBtw);
  } else if (!isPasswordComplexEnough(newPassword)) {
    return Localization.of(context)
        .trans(LocalizationValues.pwdContainAlphabetAndNum);
  }
  return null;
}

// Validates "current password" field
String currentPasswordValidator(
    {@required String currentPassword, @required BuildContext context}) {
  if (currentPassword.isEmpty) {
    return Localization.of(context).trans(LocalizationValues.enterCurrentPwd);
  } else if (!isPasswordLengthValid(currentPassword)) {
    return Localization.of(context).trans(LocalizationValues.sixCharForPwd);
  }
  return null;
}

// Validates name format
bool isNameFormatValid(String name) {
  String p = r"^[a-zA-Z]*$";
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(name);
}

// Validates name length
bool isNameLengthValid(String name) {
  if (name.trim().length >= 2 && name.trim().length <= 45) {
    return true;
  }
  return false;
}

// Validates name length
bool isPriceLengthValid(String name) {
  if (name.trim().length >= 1 && name.trim().length <= 45) {
    return true;
  }
  return false;
}

// Validates name length
bool isAssetDesLengthValid(String name) {
  if (name.trim().length >= 2 && name.trim().length <= 150) {
    return true;
  }
  return false;
}

// Validates phone length
bool isPhoneNumberLengthValid(String phoneNumber) {
  if (phoneNumber.trim().length >= 6 && phoneNumber.trim().length <= 15) {
    return true;
  }
  return false;
}

// Validates first name
String firstNameValidator(
    {@required String firstName, @required BuildContext context}) {
  if (firstName.trim().isEmpty) {
    return Localization.of(context).trans(LocalizationValues.enterFirstName);
  } else if (!isNameLengthValid(firstName.trim())) {
    return Localization.of(context)
        .trans(LocalizationValues.firstName2To45Chars);
  } else if (!isNameFormatValid(firstName.trim())) {
    return Localization.of(context)
        .trans(LocalizationValues.noSpecialCharAllowed);
  }
  return null;
}

// Validates  name
String usernameValidator(
    {@required String name, @required BuildContext context}) {
  if (name.trim().isEmpty) {
    return "Please enter username.";
  } else if (!isNameLengthValid(name.trim())) {
    return "Please enter username between 2-45 characters.";
  }
  return null;
}

// Validates last name
String lastNameValidator(
    {@required String lastName, @required BuildContext context}) {
  if (lastName.trim().isEmpty) {
    return Localization.of(context).trans(LocalizationValues.enterLastName);
  } else if (!isNameLengthValid(lastName.trim())) {
    return 'Please enter last name between 2-45 characters.';
  } else if (!isNameFormatValid(lastName.trim())) {
    return Localization.of(context)
        .trans(LocalizationValues.noSpecialCharAllowed);
  }
  return null;
}

// Validates  name
String fullNameValidator(
    {@required String name, @required BuildContext context}) {
  if (name.trim().isEmpty) {
    return "Please enter Name.";
  } else if (!isNameLengthValid(name.trim())) {
    return "Please enter Name between 2-45 characters.";
  }
  return null;
}

// Validates  contact name
String contactNameValidator(
    {@required String contactName, @required BuildContext context}) {
  if (contactName.trim().isEmpty) {
    return Localization.of(context).trans(LocalizationValues.enterContactName);
  } else if (!isNameLengthValid(contactName.trim())) {
    return Localization.of(context)
        .trans(LocalizationValues.contactName2To45Chars);
  }
  return null;
}

// Validates  stateRegion
String stateRegionValidator(
    {@required String stateRegion, @required BuildContext context}) {
  if (stateRegion.trim().isEmpty) {
    return Localization.of(context).trans(LocalizationValues.enterStateRegion);
  }
  return null;
}

// Validates  zipCode
String zipCodeValidator(
    {@required String zipCode, @required BuildContext context}) {
  if (zipCode.trim().isEmpty) {
    return Localization.of(context).trans(LocalizationValues.enterZipCode);
  }
  return null;
}

// Validates  country
String countryValidator(
    {@required String country, @required BuildContext context}) {
  if (country.trim().isEmpty) {
    return Localization.of(context).trans(LocalizationValues.enterCountry);
  }
  return null;
}

// Validates  name
String assetAmountValidator(
    {@required String name, @required BuildContext context}) {
  if (name.trim().isEmpty) {
    return "Please enter Amount.";
  }
  return null;
}

// Validates  name
String assetNameValidator(
    {@required String name, @required BuildContext context}) {
  if (name.trim().isEmpty) {
    return "Please enter Asset Name.";
  } else if (!isAssetDesLengthValid(name.trim())) {
    return "Please enter asset name between 2-100 characters.";
  }
  return null;
}
