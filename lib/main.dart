import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'models/bit_conversion_model.dart';
import 'models/character_count_model.dart';
import 'models/clock_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CharacterCountModel()),
        ChangeNotifierProvider(create: (_) => BitConversionModel()),
        ChangeNotifierProvider(create: (_) => ClockModel()),
      ],
      child: const UtilityToolkitApp(),
    ),
  );
}
