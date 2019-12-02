import 'package:flutter/services.dart';

class DecimalNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    print("oldValue: ${oldValue.text}");
    print("newValue: ${newValue.text}");

//    String p = r"^(\d+)?([.]?\d{0,2})?$";
//    String p = r"^[0-9]\d{0,5}(\.\d{0,2})*(,\d+)?$";
    String p = r"^\d{0,6}(\.\d{0,2})?$";//todo
//    String p = r"^\$|^(0|([1-9][0-9]{0,3}))(\\.[0-9]{0,2})?\$";
    RegExp regExp = new RegExp(p);

    String updatedText;
    int selectionIndex;

    if (regExp.hasMatch(newValue.text)) {
      updatedText = newValue.text;
      selectionIndex = newValue.selection.end;
    } else {
      updatedText = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }

    return TextEditingValue(
      text: updatedText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}