import 'package:flutter_test/flutter_test.dart';
import 'package:improved_parakeet/models/bit_conversion_model.dart';

void main() {
  group('BitConversionModel', () {
    late BitConversionModel model;

    setUp(() {
      model = BitConversionModel();
    });

    test('initial state has empty fields and no error', () {
      expect(model.binary, '');
      expect(model.decimal, '');
      expect(model.hex, '');
      expect(model.errorMessage, '');
    });

    group('binary → decimal and hex', () {
      test('converts 1010 to decimal 10 and hex A', () {
        model.updateFromBinary('1010');
        expect(model.decimal, '10');
        expect(model.hex, 'A');
      });

      test('converts 1111 to decimal 15 and hex F', () {
        model.updateFromBinary('1111');
        expect(model.decimal, '15');
        expect(model.hex, 'F');
      });

      test('converts 11111111 to decimal 255 and hex FF', () {
        model.updateFromBinary('11111111');
        expect(model.decimal, '255');
        expect(model.hex, 'FF');
      });

      test('converts 0 to decimal 0 and hex 0', () {
        model.updateFromBinary('0');
        expect(model.decimal, '0');
        expect(model.hex, '0');
      });
    });

    group('decimal → binary and hex', () {
      test('converts 10 to binary 1010 and hex A', () {
        model.updateFromDecimal('10');
        expect(model.binary, '1010');
        expect(model.hex, 'A');
      });

      test('converts 255 to binary 11111111 and hex FF', () {
        model.updateFromDecimal('255');
        expect(model.binary, '11111111');
        expect(model.hex, 'FF');
      });

      test('converts 0 correctly', () {
        model.updateFromDecimal('0');
        expect(model.binary, '0');
        expect(model.hex, '0');
      });
    });

    group('hex → binary and decimal', () {
      test('converts A to binary 1010 and decimal 10', () {
        model.updateFromHex('A');
        expect(model.binary, '1010');
        expect(model.decimal, '10');
      });

      test('converts FF to binary 11111111 and decimal 255', () {
        model.updateFromHex('FF');
        expect(model.binary, '11111111');
        expect(model.decimal, '255');
      });

      test('is case-insensitive for hex input', () {
        model.updateFromHex('ff');
        expect(model.decimal, '255');
      });
    });

    group('invalid input handling', () {
      test('invalid binary shows error and clears other fields', () {
        model.updateFromBinary('1012');
        expect(model.errorMessage, isNotEmpty);
        expect(model.decimal, '');
        expect(model.hex, '');
      });

      test('invalid decimal shows error', () {
        model.updateFromDecimal('abc');
        expect(model.errorMessage, isNotEmpty);
      });

      test('invalid hex shows error', () {
        model.updateFromHex('GHI');
        expect(model.errorMessage, isNotEmpty);
      });

      test('empty binary input clears all fields and error', () {
        model.updateFromBinary('1010');
        model.updateFromBinary('');
        expect(model.decimal, '');
        expect(model.hex, '');
        expect(model.errorMessage, '');
      });
    });

    group('large integers', () {
      test('handles large binary numbers', () {
        model.updateFromBinary('1' * 64);
        expect(model.decimal, isNotEmpty);
        expect(model.hex, isNotEmpty);
        expect(model.errorMessage, '');
      });
    });
  });
}
