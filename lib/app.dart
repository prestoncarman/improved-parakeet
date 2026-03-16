import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/about_page.dart';
import 'pages/bit_conversion_page.dart';
import 'pages/character_counter_page.dart';
import 'pages/clock_page.dart';
import 'theme.dart';
import 'widgets/app_scaffold.dart';

/// Root application widget with routing configured.
class UtilityToolkitApp extends StatelessWidget {
  const UtilityToolkitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Utility Toolkit',
      theme: wwuTheme,
      routerConfig: _router,
    );
  }
}

/// Application router with named routes for each tool.
final _router = GoRouter(
  initialLocation: '/clock',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppScaffold(child: child),
      routes: [
        GoRoute(
          path: '/character-counter',
          builder: (context, state) => const CharacterCounterPage(),
        ),
        GoRoute(
          path: '/bit-conversion',
          builder: (context, state) => const BitConversionPage(),
        ),
        GoRoute(
          path: '/clock',
          builder: (context, state) => const ClockPage(),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => const AboutPage(),
        ),
      ],
    ),
  ],
);
