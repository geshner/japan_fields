import 'package:flutter/services.dart';

/// A [TextInputFormatter] that format the input to credit card format
/// (XXXX XXXX XXXX XXXX).
class CreditCardInputFormatter extends TextInputFormatter {
  //define the field max length
  final int maxLength = 16;

  CreditCardInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueLength = newValue.text.length;
    var substrIndex = 0;

    if (newValueLength == 0) {
      return newValue;
    }

    if (newValueLength > maxLength) {
      return oldValue;
    }

    final newText = StringBuffer();

    if (newValueLength >= 4) {
      for(var index = 4; index < newValueLength; index += 4) {
        newText.write('${newValue.text.substring(index - 4, substrIndex = index)} ');
      }
    }

    if (newValueLength > substrIndex) {
      newText.write(newValue.text.substring(substrIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}