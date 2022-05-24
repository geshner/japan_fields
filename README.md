<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->
# Japan Fields

The simplest way to use japanese formats in your application!

This package contains input formatters for common used formats in Japan.

## Features

### Formatters

| Formatter                   | Supported formats         |
|:----------------------------|:--------------------------|
| Credit card number          | 1111 2222 3333 4444       |
| Credit card expiration date | 12/26                     |
| Date                        | 1900/01/01 or 1900年01月01日 |
| Phone                       | 123-456-7890              |
| Postal code                 | 123-4567 or 〒123-4567     |
| Time                        | 23:59                     |
| Yen                         | 1,000,000 or ￥1,000,000   |

## Getting started

To use this package as library, depend on it.

1. Run this command (with flutter)
```shell
flutter pub add japan_fields
```
This will add a line like this to yours pubspec.yaml
```yaml
dependencies:
  japan_fields: ^0.1.0
```
2. Run this command (with flutter)
```shell
flutter pub get
```
3. Import it in your Dart code
```dart
import 'package:japan_fields/japan_fields.dart';
```

## Usage

Just include the formatter of your need to the input formatters list of the field.

To ensure that the field only accepts numeric values, used in conjunction with the FilteringTextInputFormatter.digitsOnly formatter.

```dart
TextField(
  inputFormatters: [
    //Add to ensure that only numeric values is accepted
    FilteringTextinputFormatter.digitysOnly,
    CreditCardInputFormatter(),
  ],
);

TextField(
  inputFormatters: [
    //Add to ensure that only numeric values is accepted
    FilteringTextinputFormatter.digitysOnly,
    //Passing true to enableMark will format with the postal code mark
    PostalCodeInputFormatter(enableMark: true),
  ],
);

TextField(
  inputFormatters: [
    //Add to ensure that only numeric values is accepted
    FilteringTextinputFormatter.digitysOnly,
    //Passing true to enableYenMark will format with the yen mark
    YenInputFormatter(enableYenMark: true),
  ],
);
```
