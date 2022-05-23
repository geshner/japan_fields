import 'package:flutter/services.dart';

/// A [TextInputFormatter] that format the input to date format used in Japan
/// format: yyyy/MM/dd
class DateInputFormatter extends TextInputFormatter {
  //define the field max length
  final int maxLength = 8;
  final bool useJapaneseSeparator;
  final String yearSeparator;
  final String monthSeparator;
  final String daySeparator;

  DateInputFormatter({this.useJapaneseSeparator = false})
      : yearSeparator = useJapaneseSeparator ? '年' : '/',
        monthSeparator = useJapaneseSeparator ? '月' : '/',
        daySeparator = useJapaneseSeparator ? '日' : '';

  // TODO add support for years with 3 chars or less

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

    final newText = StringBuffer();
    var substrIndex = 0;

    if (newValueLength >= 4) {
      newText
          .write(newValue.text.substring(0, substrIndex = 4) + yearSeparator);
    }

    if (newValueLength >= 6) {
      newText.write(newValue.text.substring(substrIndex, substrIndex = 6) +
          monthSeparator);
    }

    if (useJapaneseSeparator && newValueLength > 6) {
      newText.write('${newValue.text.substring(substrIndex)}日');
      substrIndex = newValueLength;
    }

    if (newValueLength > substrIndex) {
      newText.write(newValue.text.substring(substrIndex));
    }

    return TextEditingValue(
        text: newText.toString(),
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
