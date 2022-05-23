import 'package:flutter/services.dart';

/// A [TextInputFormatter] that format the input to mobile phone format
/// (XXX-XXXX-XXXX)
class PhoneInputFormatter extends TextInputFormatter {
  //define the field max length
  final int maxLength = 11;

  PhoneInputFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueLength = newValue.text.length;

    if (newValueLength == 0) {
      return newValue;
    }

    if(newValueLength > maxLength) {
      return oldValue;
    }

    var substrIndex = 0;
    final newText = StringBuffer();

    if (newValueLength >= 3) {
      newText.write('${newValue.text.substring(0, substrIndex = 3)}-');
    }

    if (newValueLength >= 7) {
      newText.write('${newValue.text.substring(substrIndex, substrIndex = 7)}-');
    }

    if(newValueLength > substrIndex) {
      newText.write(newValue.text.substring(substrIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

}