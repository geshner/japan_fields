import 'package:flutter/services.dart';

/// A [TextInputFormatter] that format the input to the japanese postal code
/// format(XXX-XXXX).
///
/// If [enableMark] is true, then the postal code mark (〒) will be add at
/// the beginning of input
class PostalCodeInputFormatter extends TextInputFormatter {
  //define the field max length
  final int maxLength = 7;

  final bool enableMark;

  PostalCodeInputFormatter({this.enableMark = false});

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

    if (enableMark) {
      newText.write('〒');
    }

    if (newValueLength >= 4) {
      newText.write('${newValue.text.substring(0, substrIndex = 3)}-');
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