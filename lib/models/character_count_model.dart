import 'package:flutter/foundation.dart';

/// Model for the Character Counter tool.
///
/// Tracks a text string and exposes derived counts.
class CharacterCountModel extends ChangeNotifier {
  String _text = '';

  String get text => _text;

  /// Total number of characters including spaces.
  int get totalChars => _text.length;

  /// Number of characters excluding spaces.
  int get charsNoSpaces => _text.replaceAll(' ', '').length;

  /// Number of words (whitespace-delimited tokens).
  int get wordCount =>
      _text.trim().isEmpty ? 0 : _text.trim().split(RegExp(r'\s+')).length;

  /// Update the tracked text and notify listeners.
  void updateText(String newText) {
    _text = newText;
    notifyListeners();
  }
}
