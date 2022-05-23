import 'package:flutter/services.dart';

/// A [TextInputFormatter] that formats the input value to hour format HH:mm
class TimeInputFormatter extends TextInputFormatter {
  //define max length
  final int maxLength = 4;

  TimeInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueLength = newValue.text.length;

    if (newValueLength == 0) {
      return newValue;
    }

    if (newValueLength > maxLength) {
      return oldValue;
    }

    var substrIndex = 0;
    final newText = StringBuffer();

    switch (newValueLength) {
      case 1:
        final hour = int.parse(newValue.text);
        if (hour >= 3) {
          return oldValue;
        }
        break;
      case 2:
        final hour = int.parse(newValue.text);
        if (hour >= 24) {
          return oldValue;
        }
        break;
      case 3:
        final minute = int.parse(newValue.text.substring(2));
        if (minute >= 6) {
          return oldValue;
        }
        newText.write('${newValue.text.substring(0, substrIndex = 2)}:');
        break;
      case 4:
        final minute = int.parse(newValue.text.substring(2));
        if (minute >= 60) {
          return oldValue;
        }
        newText.write('${newValue.text.substring(0, substrIndex = 2)}:');
        break;
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