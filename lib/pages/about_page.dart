import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const _repoUrl = 'https://github.com/prestoncarman/improved-parakeet';
const _issuesUrl =
    'https://github.com/prestoncarman/improved-parakeet/issues/new';
const _contributingUrl =
    'https://github.com/prestoncarman/improved-parakeet/blob/main/CONTRIBUTING.md';

/// About page describing the project and how to contribute or submit feedback.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final headlineStyle = Theme.of(context).textTheme.headlineMedium;
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About', style: headlineStyle),
          const SizedBox(height: 8),
          Text(
            'Utility Toolkit is a collection of small, focused tools built to '
            'support teaching and learning in CS courses. Each tool runs '
            'entirely in your browser — no account or installation required.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),

          // Tools section
          Text('Tools', style: titleStyle),
          const SizedBox(height: 12),
          const _ToolCard(
            icon: Icons.access_time,
            title: 'Clock & Countdown',
            description:
                'A live digital clock with a countdown timer. Pick a target '
                'time and watch the seconds tick down — useful for timed '
                'exercises or lab deadlines.',
          ),
          const SizedBox(height: 8),
          const _ToolCard(
            icon: Icons.text_fields,
            title: 'Character Counter',
            description:
                'Paste or type any text to instantly see the total character '
                'count, character count excluding spaces, and word count. '
                'Handy for checking assignment length limits.',
          ),
          const SizedBox(height: 8),
          const _ToolCard(
            icon: Icons.memory,
            title: 'Bit Conversion',
            description:
                'Convert numbers between binary, decimal, and hexadecimal. '
                'Edit any field and the other two update automatically. '
                'Supports arbitrarily large integers.',
          ),

          const SizedBox(height: 32),

          // Contribute section
          Text('Contribute', style: titleStyle),
          const SizedBox(height: 12),
          Text(
            'This project is open source and welcomes contributions. You can '
            'add a new tool, improve an existing one, fix a bug, or update '
            'the documentation.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          const Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _LinkButton(
                icon: Icons.code,
                label: 'View on GitHub',
                url: _repoUrl,
              ),
              _LinkButton(
                icon: Icons.menu_book,
                label: 'Contributing Guide',
                url: _contributingUrl,
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Feedback section
          Text('Feedback & Submissions', style: titleStyle),
          const SizedBox(height: 12),
          Text(
            'Found a bug? Have an idea for a new tool? Open an issue on '
            'GitHub — all feedback is welcome.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          const _LinkButton(
            icon: Icons.feedback_outlined,
            label: 'Submit Feedback or Idea',
            url: _issuesUrl,
            filled: true,
          ),
        ],
      ),
    );
  }
}

class _ToolCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _ToolCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String url;
  final bool filled;

  const _LinkButton({
    required this.icon,
    required this.label,
    required this.url,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    void onPressed() => launchUrl(Uri.parse(url));

    if (filled) {
      return FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
      );
    }
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
