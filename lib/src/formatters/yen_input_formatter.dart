import 'package:flutter/services.dart';

/// A [TextInputFormatter] that formats the input to the japanese yen format
/// when [enableYenMark] is true, it's add the ￥ at the start of the input.
/// the default [maxLength] is set to 12.
/// the default output format is 900,000,000,000
class YenInputFormatter extends TextInputFormatter {
  final int maxLength;
  final bool enableYenMark;

  YenInputFormatter({
    this.maxLength = 12,
    this.enableYenMark = false,
  });

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

    if (enableYenMark) {
      newText.write('￥');
    }

    newText.write(_addSeparator(newValue.text));

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  String _addSeparator(String value) {

    var formattedValue = '';
    var separatorCount = 0;

    for(var i = value.length - 1; i > -1; i--) {
      if (separatorCount == 3) {
        formattedValue = ',$formattedValue';
        separatorCount = 0;
      }
      separatorCount++;
      formattedValue = value[i] + formattedValue;
    }

    return formattedValue;
  }
}
