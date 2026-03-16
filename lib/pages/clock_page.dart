import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/clock_model.dart';

/// Page for the Clock & Countdown Timer tool.
class ClockPage extends StatelessWidget {
  const ClockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Consumer<ClockModel>(
          builder: (context, model, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Clock takes exactly half the available height
                SizedBox(
                  height: constraints.maxHeight / 2,
                  child: Card(
                    margin: const EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Current Time',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          // FittedBox scales the time text to fill available space
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                model.formattedTime,
                                style: const TextStyle(
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Countdown section fills the remaining half
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Countdown Timer',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () => _pickDeadline(context, model),
                          icon: const Icon(Icons.schedule),
                          label: const Text('Set Countdown Time'),
                        ),
                        if (model.hasDeadline) ...[
                          const SizedBox(height: 8),
                          TextButton.icon(
                            onPressed: model.clearDeadline,
                            icon: const Icon(Icons.clear),
                            label: const Text('Clear'),
                          ),
                          const SizedBox(height: 8),
                          _CountdownCard(model: model),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Shows a time picker and sets the deadline to that time today,
  /// or tomorrow if the time has already passed.
  Future<void> _pickDeadline(BuildContext context, ClockModel model) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked == null) return;

    final now = DateTime.now();
    var deadline =
        DateTime(now.year, now.month, now.day, picked.hour, picked.minute);

    // If the chosen time is already in the past today, target tomorrow
    if (deadline.isBefore(now)) {
      deadline = deadline.add(const Duration(days: 1));
    }

    model.setDeadline(deadline);
  }
}

/// Card showing the deadline time and countdown (or "Deadline reached").
class _CountdownCard extends StatelessWidget {
  final ClockModel model;

  const _CountdownCard({required this.model});

  @override
  Widget build(BuildContext context) {
    final deadline = model.deadline!;
    final h = deadline.hour.toString().padLeft(2, '0');
    final m = deadline.minute.toString().padLeft(2, '0');

    return Card(
      color: model.deadlineReached
          ? Theme.of(context).colorScheme.errorContainer
          : Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deadline: $h:$m',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            if (model.deadlineReached)
              Text(
                'Deadline reached',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
              )
            else ...[
              Text(
                'Time remaining:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                model.countdownText,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
