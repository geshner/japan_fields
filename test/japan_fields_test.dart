import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:japan_fields/src/formatters/postal_code_input_formatter.dart';

void main() {
  TextEditingValue testOldValue = TextEditingValue.empty;
  TextEditingValue testNewValue = TextEditingValue.empty;
  late PostalCodeInputFormatter postalCodeInputFormatter;

  group('test postal code formatter (enableMark: true)', () {
    setUp(
      () =>
          postalCodeInputFormatter = PostalCodeInputFormatter(enableMark: true),
    );

    test('when input more than 8 numbers should return old value', () {
      testNewValue = const TextEditingValue(text: '123456789');
      expect(
        postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue),
        testOldValue,
      );
    });

    test('when input less than 4 number should add postal code mark on start',
        () {
      testNewValue = const TextEditingValue(text: '123');
      expect(
        postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '〒123',
          selection: TextSelection.collapsed(offset: 4),
        ),
      );

      testNewValue = const TextEditingValue(text: '12');
      expect(
        postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '〒12',
          selection: TextSelection.collapsed(offset: 3),
        ),
      );

      testNewValue = const TextEditingValue(text: '1');
      expect(
        postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '〒1',
          selection: TextSelection.collapsed(offset: 2),
        ),
      );
    });

    test('when input between 4 and 7 letters should return with mask', () {
      testNewValue = const TextEditingValue(text: '1234');
      expect(
        postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '〒123-4',
          selection: TextSelection.collapsed(offset: 6),
        ),
      );

      testNewValue = const TextEditingValue(text: '12345');
      expect(
        postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '〒123-45',
          selection: TextSelection.collapsed(offset: 7),
        ),
      );

      testNewValue = const TextEditingValue(text: '123456');
      expect(
        postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '〒123-456',
          selection: TextSelection.collapsed(offset: 8),
        ),
      );

      testNewValue = const TextEditingValue(text: '1234567');
      expect(
        postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '〒123-4567',
          selection: TextSelection.collapsed(offset: 9),
        ),
      );
    });

    test('when clear input should clear mask', () {
      testNewValue = const TextEditingValue(text: '1234567');
      testOldValue =
          postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue);

      expect(
        testOldValue,
        const TextEditingValue(
          text: '〒123-4567',
          selection: TextSelection.collapsed(offset: 9),
        ),
      );

      testNewValue = TextEditingValue.empty;
      expect(
        postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue),
        testNewValue,
      );
    });
  });

  group('test postal code formatter (enableMark: false)', () {
    setUp(() => postalCodeInputFormatter = PostalCodeInputFormatter());

    test('when input more than 8 numbers should return old value', () {
      testNewValue = const TextEditingValue(text: '123456789');
      expect(
        postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue),
        testOldValue,
      );
    });

    test('when input less than 4 number should add postal code mark on start',
        () {
      testNewValue = const TextEditingValue(text: '123');
      expect(
        postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '123',
          selection: TextSelection.collapsed(offset: 3),
        ),
      );

      testNewValue = const TextEditingValue(text: '12');
      expect(
        postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '12',
          selection: TextSelection.collapsed(offset: 2),
        ),
      );

      testNewValue = const TextEditingValue(text: '1');
      expect(
        postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '1',
          selection: TextSelection.collapsed(offset: 1),
        ),
      );
    });

    test('when input between 4 and 7 letters should return with mask', () {
      testNewValue = const TextEditingValue(text: '1234');
      expect(
          postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue),
          const TextEditingValue(
            text: '123-4',
            selection: TextSelection.collapsed(offset: 5),
          ));

      testNewValue = const TextEditingValue(text: '12345');
      expect(
        postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '123-45',
          selection: TextSelection.collapsed(offset: 6),
        ),
      );

      testNewValue = const TextEditingValue(text: '123456');
      expect(
        postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '123-456',
          selection: TextSelection.collapsed(offset: 7),
        ),
      );

      testNewValue = const TextEditingValue(text: '1234567');
      expect(
        postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '123-4567',
          selection: TextSelection.collapsed(offset: 8),
        ),
      );
    });

    test('when clear input should clear mask', () {
      testNewValue = const TextEditingValue(text: '1234567');
      testOldValue =
          postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue);

      expect(
        testOldValue,
        const TextEditingValue(
          text: '123-4567',
          selection: TextSelection.collapsed(offset: 8),
        ),
      );

      testNewValue = TextEditingValue.empty;
      expect(
        postalCodeInputFormatter.formatEditUpdate(testOldValue, testNewValue),
        testNewValue,
      );
    });
  });
}
