import 'package:flutter/services.dart';

/// A [TextInputFormatter] that format the input to credit card expiration date
/// format (XX/XX).
class CreditCardExpirationDateInputFormatter extends TextInputFormatter {
  final int maxLength = 4;

  CreditCardExpirationDateInputFormatter();

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

    if (newValueLength >= 3) {
      newText.write('${newValue.text.substring(0, substrIndex = 2)}/');
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
