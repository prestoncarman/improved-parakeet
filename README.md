# Utility Toolkit

A Flutter Web application providing a small toolkit of interactive utilities.

[![Deploy to GitHub Pages](https://github.com/prestoncarman/improved-parakeet/actions/workflows/deploy.yml/badge.svg)](https://github.com/prestoncarman/improved-parakeet/actions/workflows/deploy.yml)

## Live Demo

**[https://prestoncarman.github.io/improved-parakeet/](https://prestoncarman.github.io/improved-parakeet/)**

## Tools

| Tool | Description |
|------|-------------|
| **Character Counter** | Real-time character, word, and space counting |
| **Bit Conversion** | Convert between binary, decimal, and hexadecimal |
| **Clock & Countdown** | Live clock with deadline countdown timer |

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.0 or later
- Dart SDK (included with Flutter)

### Run Locally

```bash
git clone https://github.com/prestoncarman/improved-parakeet.git
cd improved-parakeet
flutter pub get
flutter run -d chrome
```

### Run Tests

```bash
flutter test
```

Run with verbose output:

```bash
flutter test --reporter expanded
```

### Build for Production

```bash
flutter build web --release --base-href /improved-parakeet/
```

Built files are written to `build/web/`.

## Project Structure

```
lib/
├── main.dart                        # App entry point and Provider setup
├── app.dart                         # Router and MaterialApp configuration
├── models/
│   ├── character_count_model.dart   # Character/word count state
│   ├── bit_conversion_model.dart    # Binary/decimal/hex conversion state
│   └── clock_model.dart             # Live clock and countdown state
├── pages/
│   ├── character_counter_page.dart  # Character Counter tool UI
│   ├── bit_conversion_page.dart     # Bit Conversion tool UI
│   └── clock_page.dart              # Clock & Countdown tool UI
└── widgets/
    └── app_scaffold.dart            # Navigation rail + layout scaffold
test/
├── character_counter_test.dart
├── bit_conversion_test.dart
└── clock_test.dart
```

## CI/CD

GitHub Actions runs on every push to `main`:

1. **Test** — format check, `flutter analyze`, `flutter test`
2. **Build** — `flutter build web --base-href /improved-parakeet/`, uploads result as a workflow artifact (retained 7 days)
3. **Deploy** — downloads the artifact and pushes it to the `gh-pages` branch via `peaceiris/actions-gh-pages`

On pull requests only the **Test** job runs; the deploy is skipped.

See [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml).

### Enabling GitHub Pages

1. Go to **Settings → Pages** in your repository
2. Set **Source** to **Deploy from a branch**
3. Set **Branch** to `gh-pages` / `/ (root)`
4. Push to `main` to trigger the first deployment

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT License — see [LICENSE](LICENSE).
