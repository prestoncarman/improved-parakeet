import 'package:flutter_test/flutter_test.dart';
import 'package:improved_parakeet/models/character_count_model.dart';

void main() {
  group('CharacterCountModel', () {
    late CharacterCountModel model;

    setUp(() {
      model = CharacterCountModel();
    });

    test('initial state is empty', () {
      expect(model.text, '');
      expect(model.totalChars, 0);
      expect(model.charsNoSpaces, 0);
      expect(model.wordCount, 0);
    });

    test('counts total characters including spaces', () {
      model.updateText('Hello World');
      expect(model.totalChars, 11);
    });

    test('counts characters excluding spaces', () {
      model.updateText('Hello World');
      expect(model.charsNoSpaces, 10);
    });

    test('counts words correctly', () {
      model.updateText('Hello World');
      expect(model.wordCount, 2);
    });

    test('handles empty input', () {
      model.updateText('');
      expect(model.totalChars, 0);
      expect(model.charsNoSpaces, 0);
      expect(model.wordCount, 0);
    });

    test('handles whitespace-only input', () {
      model.updateText('   ');
      expect(model.wordCount, 0);
      expect(model.totalChars, 3);
      expect(model.charsNoSpaces, 0);
    });

    test('multiple spaces count as one word separator', () {
      model.updateText('Hello   World');
      expect(model.wordCount, 2);
    });

    test('single word has word count of 1', () {
      model.updateText('Hello');
      expect(model.wordCount, 1);
    });

    test('counts newlines as characters', () {
      model.updateText('line1\nline2');
      expect(model.totalChars, 11);
      expect(model.wordCount, 2);
    });
  });
}
