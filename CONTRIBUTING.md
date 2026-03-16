# Contributing to Utility Toolkit

Thank you for your interest in contributing!

## Development Setup

1. Fork and clone the repository
2. Install Flutter: <https://docs.flutter.dev/get-started/install>
3. Install dependencies:

   ```bash
   flutter pub get
   ```

## Making Changes

1. Create a feature branch:

   ```bash
   git checkout -b feature/my-feature
   ```

2. Make your changes following the code style guidelines below
3. Write or update tests for your changes
4. Verify everything passes:

   ```bash
   dart format .
   flutter analyze
   flutter test
   ```

5. Commit and push, then open a Pull Request

## Code Style

- Follow the [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Run `dart format .` before committing
- Keep widgets small and focused — extract sub-widgets when a widget grows beyond ~80 lines
- Add comments for non-obvious logic; avoid restating what the code already says
- Enable and respect all lint rules in `analysis_options.yaml`

## Adding a New Tool

1. Create a `ChangeNotifier` model in `lib/models/`
2. Create a page widget in `lib/pages/`
3. Register a new `GoRoute` in `lib/app.dart`
4. Add a `NavigationRailDestination` in `lib/widgets/app_scaffold.dart`
5. Write unit tests in `test/`

## Testing

All models must have unit tests. Run the full suite with:

```bash
flutter test
```

## Pull Request Guidelines

- Keep PRs focused on a single concern
- Include a clear description of *what* changed and *why*
- All CI checks must pass before merging
- Update `README.md` or this file if your change affects setup or workflow
