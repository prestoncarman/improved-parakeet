import 'package:flutter/foundation.dart';

/// Model for the Bit Conversion tool.
///
/// Holds binary, decimal, and hexadecimal representations of the same value.
/// Updating any one field automatically derives the other two.
class BitConversionModel extends ChangeNotifier {
  String _binary = '';
  String _decimal = '';
  String _hex = '';
  String _errorMessage = '';

  String get binary => _binary;
  String get decimal => _decimal;
  String get hex => _hex;
  String get errorMessage => _errorMessage;

  /// Update from a binary string and derive decimal and hex.
  void updateFromBinary(String value) {
    _binary = value;
    if (value.isEmpty) {
      _decimal = '';
      _hex = '';
      _errorMessage = '';
    } else {
      try {
        final parsed = BigInt.parse(value, radix: 2);
        _decimal = parsed.toString();
        _hex = parsed.toRadixString(16).toUpperCase();
        _errorMessage = '';
      } catch (_) {
        _decimal = '';
        _hex = '';
        _errorMessage = 'Invalid binary number';
      }
    }
    notifyListeners();
  }

  /// Update from a decimal string and derive binary and hex.
  void updateFromDecimal(String value) {
    _decimal = value;
    if (value.isEmpty) {
      _binary = '';
      _hex = '';
      _errorMessage = '';
    } else {
      try {
        final parsed = BigInt.parse(value);
        _binary = parsed.toRadixString(2);
        _hex = parsed.toRadixString(16).toUpperCase();
        _errorMessage = '';
      } catch (_) {
        _binary = '';
        _hex = '';
        _errorMessage = 'Invalid decimal number';
      }
    }
    notifyListeners();
  }

  /// Update from a hexadecimal string and derive binary and decimal.
  void updateFromHex(String value) {
    _hex = value;
    if (value.isEmpty) {
      _binary = '';
      _decimal = '';
      _errorMessage = '';
    } else {
      try {
        final parsed = BigInt.parse(value, radix: 16);
        _binary = parsed.toRadixString(2);
        _decimal = parsed.toString();
        _errorMessage = '';
      } catch (_) {
        _binary = '';
        _decimal = '';
        _errorMessage = 'Invalid hexadecimal number';
      }
    }
    notifyListeners();
  }
}
