import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ---------------------------------------------------------------------------
// Walla Walla University brand colors
// Source: https://www.wallawalla.edu/about-wwu/marketing-and-university-relations/wwu-identity
// ---------------------------------------------------------------------------

// Primary palette
const _wwuGreen = Color(0xFF656950); // primary brand color
const _wwuBrown = Color(0xFF796249);
const _wwuOrange = Color(0xFFC36D2A);

// Secondary palette
const _wwuBeige = Color(0xFFC7AE86);
const _wwuBlue = Color(0xFF667FA4);
const _wwuRed = Color(0xFF961400);

// Tonal surfaces derived from the primary green
const _greenContainer = Color(0xFFDDE5CE);
const _onGreenContainer = Color(0xFF1A2310);
const _brownContainer = Color(0xFFEFDFC8);
const _onBrownContainer = Color(0xFF271A0A);
const _orangeContainer = Color(0xFFFFDCC0);
const _onOrangeContainer = Color(0xFF3A1900);
const _surface = Color(0xFFF8F4EE); // warm off-white background
const _onSurface = Color(0xFF1C1B19);
const _surfaceVariant = Color(0xFFEDE8DD);
const _onSurfaceVariant = Color(0xFF4D4A42);

/// Walla Walla University brand theme.
///
/// Colors follow the official WWU identity guide.
/// Typography uses Playfair Display (headings) and Lora (body) as
/// web-safe serif alternatives to the brand's Fairfield LT Std.
final wwuTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    // Primary — WWU Green
    primary: _wwuGreen,
    onPrimary: Colors.white,
    primaryContainer: _greenContainer,
    onPrimaryContainer: _onGreenContainer,
    // Secondary — WWU Brown
    secondary: _wwuBrown,
    onSecondary: Colors.white,
    secondaryContainer: _brownContainer,
    onSecondaryContainer: _onBrownContainer,
    // Tertiary — WWU Orange
    tertiary: _wwuOrange,
    onTertiary: Colors.white,
    tertiaryContainer: _orangeContainer,
    onTertiaryContainer: _onOrangeContainer,
    // Error — WWU Red
    error: _wwuRed,
    onError: Colors.white,
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    // Surface
    surface: _surface,
    onSurface: _onSurface,
    surfaceContainerHighest: _surfaceVariant,
    onSurfaceVariant: _onSurfaceVariant,
    outline: Color(0xFF7E7A72),
    outlineVariant: Color(0xFFCFC9BB),
    inverseSurface: Color(0xFF312F2B),
    onInverseSurface: Color(0xFFF5F0E7),
    inversePrimary: Color(0xFFBDC9A0),
    scrim: Colors.black,
    shadow: Colors.black,
  ),
  textTheme: _buildTextTheme(),
  // Expose brand colors as extensions for bespoke widgets
  extensions: const [WwuColors()],
);

/// Builds the app text theme using Playfair Display for display/headline
/// styles and Lora for body/label styles, matching the serif character
/// of the WWU brand's Fairfield LT Std typeface.
TextTheme _buildTextTheme() {
  final base = GoogleFonts.loraTextTheme();
  final display = GoogleFonts.playfairDisplay();

  return base.copyWith(
    displayLarge: display.copyWith(fontWeight: FontWeight.bold),
    displayMedium: display.copyWith(fontWeight: FontWeight.bold),
    displaySmall: display.copyWith(fontWeight: FontWeight.bold),
    headlineLarge: display.copyWith(fontWeight: FontWeight.w600),
    headlineMedium: display.copyWith(fontWeight: FontWeight.w600),
    headlineSmall: display.copyWith(fontWeight: FontWeight.w600),
    titleLarge: display.copyWith(fontWeight: FontWeight.w600),
    titleMedium: display.copyWith(fontWeight: FontWeight.w500),
  );
}

/// Theme extension exposing the full WWU brand palette for use in
/// custom widgets that need colors beyond the Material color scheme.
@immutable
class WwuColors extends ThemeExtension<WwuColors> {
  const WwuColors();

  static const green = _wwuGreen;
  static const brown = _wwuBrown;
  static const orange = _wwuOrange;
  static const beige = _wwuBeige;
  static const blue = _wwuBlue;
  static const red = _wwuRed;

  @override
  WwuColors copyWith() => const WwuColors();

  @override
  WwuColors lerp(WwuColors? other, double t) => const WwuColors();
}
