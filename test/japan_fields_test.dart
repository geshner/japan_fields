import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:japan_fields/src/formatters/credit_card_expiration_date_input_formatter.dart';
import 'package:japan_fields/src/formatters/credit_card_input_formatter.dart';
import 'package:japan_fields/src/formatters/postal_code_input_formatter.dart';

void main() {
  TextEditingValue testOldValue = TextEditingValue.empty;
  TextEditingValue testNewValue = TextEditingValue.empty;
  late TextInputFormatter formatter;

  group('test postal code formatter (enableMark: true)', () {
    setUp(
      () => formatter = PostalCodeInputFormatter(enableMark: true),
    );

    test('when input more than 8 numbers should return old value', () {
      testNewValue = const TextEditingValue(text: '123456789');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        testOldValue,
      );
    });

    test('when input less than 4 number should add postal code mark on start',
        () {
      testNewValue = const TextEditingValue(text: '123');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '〒123',
          selection: TextSelection.collapsed(offset: 4),
        ),
      );

      testNewValue = const TextEditingValue(text: '12');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '〒12',
          selection: TextSelection.collapsed(offset: 3),
        ),
      );

      testNewValue = const TextEditingValue(text: '1');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '〒1',
          selection: TextSelection.collapsed(offset: 2),
        ),
      );
    });

    test('when input between 4 and 7 letters should return with mask', () {
      testNewValue = const TextEditingValue(text: '1234');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '〒123-4',
          selection: TextSelection.collapsed(offset: 6),
        ),
      );

      testNewValue = const TextEditingValue(text: '12345');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '〒123-45',
          selection: TextSelection.collapsed(offset: 7),
        ),
      );

      testNewValue = const TextEditingValue(text: '123456');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '〒123-456',
          selection: TextSelection.collapsed(offset: 8),
        ),
      );

      testNewValue = const TextEditingValue(text: '1234567');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '〒123-4567',
          selection: TextSelection.collapsed(offset: 9),
        ),
      );
    });

    test('when clear input should clear mask', () {
      testNewValue = const TextEditingValue(text: '1234567');
      testOldValue = formatter.formatEditUpdate(testOldValue, testNewValue);

      expect(
        testOldValue,
        const TextEditingValue(
          text: '〒123-4567',
          selection: TextSelection.collapsed(offset: 9),
        ),
      );

      testNewValue = TextEditingValue.empty;
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        testNewValue,
      );
    });
  });

  group('test postal code formatter (enableMark: false)', () {
    setUp(() => formatter = PostalCodeInputFormatter());

    test('when input more than 8 numbers should return old value', () {
      testNewValue = const TextEditingValue(text: '123456789');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        testOldValue,
      );
    });

    test('when input less than 4 number should add postal code mark on start',
        () {
      testNewValue = const TextEditingValue(text: '123');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '123',
          selection: TextSelection.collapsed(offset: 3),
        ),
      );

      testNewValue = const TextEditingValue(text: '12');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '12',
          selection: TextSelection.collapsed(offset: 2),
        ),
      );

      testNewValue = const TextEditingValue(text: '1');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '1',
          selection: TextSelection.collapsed(offset: 1),
        ),
      );
    });

    test('when input between 4 and 7 letters should return with mask', () {
      testNewValue = const TextEditingValue(text: '1234');
      expect(
          formatter.formatEditUpdate(testOldValue, testNewValue),
          const TextEditingValue(
            text: '123-4',
            selection: TextSelection.collapsed(offset: 5),
          ));

      testNewValue = const TextEditingValue(text: '12345');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '123-45',
          selection: TextSelection.collapsed(offset: 6),
        ),
      );

      testNewValue = const TextEditingValue(text: '123456');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '123-456',
          selection: TextSelection.collapsed(offset: 7),
        ),
      );

      testNewValue = const TextEditingValue(text: '1234567');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '123-4567',
          selection: TextSelection.collapsed(offset: 8),
        ),
      );
    });

    test('when clear input should clear mask', () {
      testNewValue = const TextEditingValue(text: '1234567');
      testOldValue = formatter.formatEditUpdate(testOldValue, testNewValue);

      expect(
        testOldValue,
        const TextEditingValue(
          text: '123-4567',
          selection: TextSelection.collapsed(offset: 8),
        ),
      );

      testNewValue = TextEditingValue.empty;
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        testNewValue,
      );
    });
  });

  group('test credit card input formatter', () {
    setUp(() => formatter = CreditCardInputFormatter());

    test('when input less than 4 numbers should display as is', () {
      testNewValue = const TextEditingValue(text: '123');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '123',
          selection: TextSelection.collapsed(offset: 3),
        ),
      );
    });

    test('when input between 4 and 7 numbers should display with mask', () {
      testNewValue = const TextEditingValue(text: '1234567');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '1234 567',
          selection: TextSelection.collapsed(offset: 8),
        ),
      );
    });

    test('when input between 9 and 11 numbers should displpay with mask', () {
      testNewValue = const TextEditingValue(text: '11112222333');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '1111 2222 333',
          selection: TextSelection.collapsed(offset: 13),
        ),
      );
    });

    test('when input between 11 and 16 numbers should displpay with mask', () {
      testNewValue = const TextEditingValue(text: '1111222233334444');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '1111 2222 3333 4444',
          selection: TextSelection.collapsed(offset: 19),
        ),
      );
    });

    test('when input more than allowed numbers, should return old value', () {
      testNewValue = const TextEditingValue(text: '11112222333344445');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        testOldValue,
      );
    });
  });

  group('test credit card expiration date input formatter', () {
    setUp(() => formatter = CreditCardExpirationDateInputFormatter());

    test('when input 2 numbers should display as is', () {
      testNewValue = const TextEditingValue(text: '12');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '12',
          selection: TextSelection.collapsed(offset: 2),
        ),
      );
    });

    test('when input 3 or more numbers should display with mask', () {
      testNewValue = const TextEditingValue(text: '1226');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '12/26',
          selection: TextSelection.collapsed(offset: 5),
        ),
      );
    });

    test('when input more than 4 numbers should return old value', () {
      testNewValue = const TextEditingValue(text: '12345');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        testOldValue,
      );
    });
  });
}
