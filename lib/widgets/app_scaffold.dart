import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Main layout scaffold with a persistent navigation rail.
class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/clock')) return 0;
    if (location.startsWith('/character-counter')) return 1;
    if (location.startsWith('/bit-conversion')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Utility Toolkit'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) {
              switch (index) {
                case 0:
                  context.go('/clock');
                case 1:
                  context.go('/character-counter');
                case 2:
                  context.go('/bit-conversion');
              }
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.access_time),
                label: Text('Clock &\nCountdown'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.text_fields),
                label: Text('Character\nCounter'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.memory),
                label: Text('Bit\nConversion'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}
