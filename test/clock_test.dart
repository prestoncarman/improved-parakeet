import 'package:flutter_test/flutter_test.dart';
import 'package:improved_parakeet/models/clock_model.dart';

void main() {
  group('ClockModel', () {
    late ClockModel model;

    setUp(() {
      model = ClockModel();
    });

    tearDown(() {
      model.dispose();
    });

    test('initial state has no deadline', () {
      expect(model.hasDeadline, false);
      expect(model.deadline, isNull);
    });

    test('formattedTime matches HH:MM:SS pattern', () {
      final pattern = RegExp(r'^\d{2}:\d{2}:\d{2}$');
      expect(pattern.hasMatch(model.formattedTime), isTrue);
    });

    test('setDeadline stores the deadline', () {
      final deadline = DateTime.now().add(const Duration(hours: 1));
      model.setDeadline(deadline);
      expect(model.hasDeadline, isTrue);
      expect(model.deadline, equals(deadline));
    });

    test('clearDeadline removes the deadline', () {
      model.setDeadline(DateTime.now().add(const Duration(hours: 1)));
      model.clearDeadline();
      expect(model.hasDeadline, isFalse);
      expect(model.deadline, isNull);
    });

    test('deadlineReached is false for a future deadline', () {
      model.setDeadline(DateTime.now().add(const Duration(hours: 1)));
      expect(model.deadlineReached, isFalse);
    });

    test('deadlineReached is true for a past deadline', () {
      model.setDeadline(DateTime.now().subtract(const Duration(seconds: 1)));
      expect(model.deadlineReached, isTrue);
    });

    test('countdownText returns empty string when no deadline', () {
      expect(model.countdownText, '');
    });

    test('countdownText returns "Deadline reached" for past deadline', () {
      model.setDeadline(DateTime.now().subtract(const Duration(seconds: 1)));
      expect(model.countdownText, 'Deadline reached');
    });

    test('countdownText contains "day" for multi-day deadline', () {
      model.setDeadline(DateTime.now().add(const Duration(days: 3, hours: 1)));
      expect(model.countdownText, contains('day'));
    });

    test('countdownText contains "second" for short deadline', () {
      model.setDeadline(DateTime.now().add(const Duration(seconds: 45)));
      expect(model.countdownText, contains('second'));
    });

    test('countdown does not show days for sub-day deadline', () {
      model.setDeadline(DateTime.now().add(const Duration(hours: 2)));
      expect(model.countdownText, isNot(contains('day')));
    });
  });
}
