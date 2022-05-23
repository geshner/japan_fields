import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:japan_fields/japan_fields.dart';

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

    test('when input between 9 and 11 numbers should display with mask', () {
      testNewValue = const TextEditingValue(text: '11112222333');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '1111 2222 333',
          selection: TextSelection.collapsed(offset: 13),
        ),
      );
    });

    test('when input between 11 and 16 numbers should display with mask', () {
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

  group('test phone input formatter', () {
    setUp(() => formatter = PhoneInputFormatter());

    test('when input less than 3 numbers should return as is', () {
      testNewValue = const TextEditingValue(text: '09');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '09',
          selection: TextSelection.collapsed(offset: 2),
        ),
      );
    });

    test('when input is until 6 numbers should return XXX-XXX format', () {
      testNewValue = const TextEditingValue(text: '090999');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '090-999',
          selection: TextSelection.collapsed(offset: 7),
        ),
      );
    });

    test('when input is until 10 numbers should return XXX-XXXX-XXX format',
        () {
      testNewValue = const TextEditingValue(text: '0909999888');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '090-9999-888',
          selection: TextSelection.collapsed(offset: 12),
        ),
      );
    });

    test('when input until 11 numbers should return XXX-XXXX-XXXX format', () {
      testNewValue = const TextEditingValue(text: '09099998888');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '090-9999-8888',
          selection: TextSelection.collapsed(offset: 13),
        ),
      );
    });

    test('when input is over 11 numbers should return old value', () {
      testNewValue = const TextEditingValue(text: '090999988889');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        testOldValue,
      );
    });

    test('when input is empty should return empty', () {
      testNewValue = const TextEditingValue(text: '');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        TextEditingValue.empty,
      );
    });
  });

  group('test date input formatter', () {
    group('using default separator', () {
      setUp(() => formatter = DateInputFormatter(useJapaneseSeparator: false));

      test('when input 4 numbers should return XXXX/ format', () {
        testNewValue = const TextEditingValue(text: '1500');
        expect(
          formatter.formatEditUpdate(testOldValue, testNewValue),
          const TextEditingValue(
            text: '1500/',
            selection: TextSelection.collapsed(offset: 5),
          ),
        );
      });

      test('when input 6 numbers should return XXXX/XX/ format', () {
        testNewValue = const TextEditingValue(text: '150001');
        expect(
          formatter.formatEditUpdate(testOldValue, testNewValue),
          const TextEditingValue(
            text: '1500/01/',
            selection: TextSelection.collapsed(offset: 8),
          ),
        );
      });

      test('when input 8 numbers should return XXXX/XX/XX format', () {
        testNewValue = const TextEditingValue(text: '15000101');
        expect(
          formatter.formatEditUpdate(testOldValue, testNewValue),
          const TextEditingValue(
            text: '1500/01/01',
            selection: TextSelection.collapsed(offset: 10),
          ),
        );
      });
    });

    group('using japanese separator', () {
      setUp(() => formatter = DateInputFormatter(useJapaneseSeparator: true));

      test('when input 4 numbers should return XXXX年 format', () {
        testNewValue = const TextEditingValue(text: '1500');
        expect(
          formatter.formatEditUpdate(testOldValue, testNewValue),
          const TextEditingValue(
            text: '1500年',
            selection: TextSelection.collapsed(offset: 5),
          ),
        );
      });

      test('when input 6 numbers should return XXXX年XX月 format', () {
        testNewValue = const TextEditingValue(text: '150001');
        expect(
          formatter.formatEditUpdate(testOldValue, testNewValue),
          const TextEditingValue(
            text: '1500年01月',
            selection: TextSelection.collapsed(offset: 8),
          ),
        );
      });

      test('when input 8 numbers should return XXXX年XX月XX日 format', () {
        testNewValue = const TextEditingValue(text: '15000101');
        expect(
          formatter.formatEditUpdate(testOldValue, testNewValue),
          const TextEditingValue(
            text: '1500年01月01日',
            selection: TextSelection.collapsed(offset: 11),
          ),
        );
      });
    });

    test('when input is empty should return empty', () {
      formatter = DateInputFormatter();
      testNewValue = TextEditingValue.empty;
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        TextEditingValue.empty,
      );
    });

    test('when input is less than 4 numbers return without format', () {
      formatter = DateInputFormatter();
      testNewValue = const TextEditingValue(text: '800');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '800',
          selection: TextSelection.collapsed(offset: 3),
        ),
      );
    });

    test('when input is over 8 numbers should return old value', () {
      formatter = DateInputFormatter();
      testNewValue = const TextEditingValue(text: '190001012');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        testOldValue,
      );
    });
  });

  group('test time input formatter', () {
    setUp(() => formatter = TimeInputFormatter());

    test('when input is empty, should return empty', () {
      testNewValue = TextEditingValue.empty;
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        TextEditingValue.empty,
      );
    });

    test('when input is over 4 numbers, should return old value', () {
      testNewValue = const TextEditingValue(text: '123456');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        testOldValue,
      );
    });

    test('when input is 1 number, should return with no mask', () {
      testNewValue = const TextEditingValue(text: '1');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '1',
          selection: TextSelection.collapsed(offset: 1),
        ),
      );
    });

    test('when first number is 3 or higher, should return old value', () {
      testNewValue = const TextEditingValue(text: '3');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        testOldValue,
      );

      testNewValue = const TextEditingValue(text: '5');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        testOldValue,
      );
    });

    test('when first two number is 23 or lower, should return with no mask',
        () {
      testNewValue = const TextEditingValue(text: '23');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '23',
          selection: TextSelection.collapsed(offset: 2),
        ),
      );

      testNewValue = const TextEditingValue(text: '00');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '00',
          selection: TextSelection.collapsed(offset: 2),
        ),
      );
    });

    test('when first two number is 24 or higher, should return old value', () {
      testNewValue = const TextEditingValue(text: '24');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        testOldValue,
      );

      testNewValue = const TextEditingValue(text: '99');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        testOldValue,
      );
    });

    test('when third number is 5 or lower, should return with hh:m mask', () {
      testNewValue = const TextEditingValue(text: '235');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '23:5',
          selection: TextSelection.collapsed(offset: 4),
        ),
      );

      testNewValue = const TextEditingValue(text: '000');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '00:0',
          selection: TextSelection.collapsed(offset: 4),
        ),
      );
    });

    test('when third number is 6 or higher, should return old value', () {
      testNewValue = const TextEditingValue(text: '226');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        testOldValue,
      );

      testNewValue = const TextEditingValue(text: '139');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        testOldValue,
      );
    });

    test('when last two number is 59 or lower, should return with hh:mm mask',
        () {
      testNewValue = const TextEditingValue(text: '2359');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '23:59',
          selection: TextSelection.collapsed(offset: 5),
        ),
      );

      testNewValue = const TextEditingValue(text: '0000');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        const TextEditingValue(
          text: '00:00',
          selection: TextSelection.collapsed(offset: 5),
        ),
      );
    });

    test('when last two number is 60 or higher, should return old value', () {
      testNewValue = const TextEditingValue(text: '1360');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        testOldValue,
      );

      testNewValue = const TextEditingValue(text: '1299');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        testOldValue,
      );
    });
  });

  group('test yen input formatter', () {
    test('when input is empty, should return empty', () {
      formatter = YenInputFormatter();
      testNewValue = TextEditingValue.empty;
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        TextEditingValue.empty,
      );
    });

    test(
        'when input is greater than default max length, should return old value',
        () {
      formatter = YenInputFormatter();
      testNewValue = const TextEditingValue(text: '9999999999999');
      expect(
        formatter.formatEditUpdate(testOldValue, testNewValue),
        testOldValue,
      );
    });

    group('with yen marks is disabled', () {
      setUp(() => formatter = YenInputFormatter());

      test('when input is less than 4 numbers should return with no mask', () {
        testNewValue = const TextEditingValue(text: '100');
        expect(
          formatter.formatEditUpdate(testOldValue, testNewValue),
          const TextEditingValue(
            text: '100',
            selection: TextSelection.collapsed(offset: 3),
          ),
        );
      });

      test('when input is between 4 and maxLength numbers should return with mask', () {
        testNewValue = const TextEditingValue(text: '100000000000');
        expect(
          formatter.formatEditUpdate(testOldValue, testNewValue),
          const TextEditingValue(
            text: '100,000,000,000',
            selection: TextSelection.collapsed(offset: 15),
          ),
        );
      });
    });

    group('with yen mark enabled', () {
      setUp(() => formatter = YenInputFormatter(enableYenMark: true));

      test('when input is less than 4 numbers should return with no mask', () {
        testNewValue = const TextEditingValue(text: '100');
        expect(
          formatter.formatEditUpdate(testOldValue, testNewValue),
          const TextEditingValue(
            text: '￥100',
            selection: TextSelection.collapsed(offset: 4),
          ),
        );
      });

      test('when input is between 4 and maxLength numbers should return with mask', () {
        testNewValue = const TextEditingValue(text: '100000000000');
        expect(
          formatter.formatEditUpdate(testOldValue, testNewValue),
          const TextEditingValue(
            text: '￥100,000,000,000',
            selection: TextSelection.collapsed(offset: 16),
          ),
        );
      });
    });
  });
}
