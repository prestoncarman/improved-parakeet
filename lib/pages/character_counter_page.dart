import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/character_count_model.dart';

/// Page for the Character Counter tool.
class CharacterCounterPage extends StatelessWidget {
  const CharacterCounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Character Counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Type or paste text below to count characters and words in real time.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          Consumer<CharacterCountModel>(
            builder: (context, model, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: model.updateText,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      hintText: 'Start typing here...',
                      border: OutlineInputBorder(),
                      labelText: 'Input Text',
                    ),
                  ),
                  const SizedBox(height: 24),
                  _CounterRow(label: 'Characters', value: model.totalChars),
                  const SizedBox(height: 8),
                  _CounterRow(
                    label: 'Characters (no spaces)',
                    value: model.charsNoSpaces,
                  ),
                  const SizedBox(height: 8),
                  _CounterRow(label: 'Words', value: model.wordCount),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// A single labeled count display card.
class _CounterRow extends StatelessWidget {
  final String label;
  final int value;

  const _CounterRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyLarge),
            const Spacer(),
            Text(
              value.toString(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
