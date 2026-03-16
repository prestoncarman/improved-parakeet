import 'dart:async';

import 'package:flutter/foundation.dart';

/// Model for the Clock & Countdown Timer tool.
///
/// Maintains the current time (updated every second) and an optional deadline.
class ClockModel extends ChangeNotifier {
  DateTime _currentTime = DateTime.now();
  DateTime? _deadline;
  Timer? _timer;

  ClockModel() {
    _startTimer();
  }

  DateTime get currentTime => _currentTime;
  DateTime? get deadline => _deadline;

  /// Current time formatted as HH:MM:SS.
  String get formattedTime {
    final h = _currentTime.hour.toString().padLeft(2, '0');
    final m = _currentTime.minute.toString().padLeft(2, '0');
    final s = _currentTime.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  /// Whether a deadline has been set.
  bool get hasDeadline => _deadline != null;

  /// Whether the deadline has already passed.
  bool get deadlineReached =>
      _deadline != null && DateTime.now().isAfter(_deadline!);

  /// Human-readable time string for the countdown/count-up display.
  ///
  /// Before the deadline: counts down, e.g. "3 days 4 hours 10 minutes 21 seconds".
  /// After the deadline: counts up, e.g. "2 minutes 30 seconds".
  /// Returns empty string if no deadline is set.
  String get countdownText {
    if (_deadline == null) return '';
    final now = DateTime.now();

    final span = now.isAfter(_deadline!)
        ? now.difference(_deadline!)
        : _deadline!.difference(now);

    final days = span.inDays;
    final hours = span.inHours % 24;
    final minutes = span.inMinutes % 60;
    final seconds = span.inSeconds % 60;

    final parts = <String>[];
    if (days > 0) parts.add('$days day${days != 1 ? 's' : ''}');
    if (hours > 0) parts.add('$hours hour${hours != 1 ? 's' : ''}');
    if (minutes > 0) parts.add('$minutes minute${minutes != 1 ? 's' : ''}');
    parts.add('$seconds second${seconds != 1 ? 's' : ''}');

    return parts.join(' ');
  }

  /// Set the countdown deadline.
  void setDeadline(DateTime deadline) {
    _deadline = deadline;
    notifyListeners();
  }

  /// Clear the countdown deadline.
  void clearDeadline() {
    _deadline = null;
    notifyListeners();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _currentTime = DateTime.now();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
