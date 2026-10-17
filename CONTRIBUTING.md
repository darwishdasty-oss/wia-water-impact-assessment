# Contributing to WIA

Thank you for considering contributing to WIA (Water Impact Assessment)!

WIA is a bilingual (Arabic/English), offline-first Flutter application for
criteria-based impact assessment of water infrastructure projects. We welcome
bug reports, feature proposals, documentation improvements, and especially
contributions to the criteria catalogue and its international-framework
references.

## Development setup

1. Install the Flutter SDK (>= 3.10, Dart >= 3.0).
2. Clone this repository.
3. Fetch dependencies and verify the toolchain:

```bash
flutter pub get
flutter analyze
flutter test
```

All three commands must pass before a pull request can be merged. The unit
tests in `test/` cover the assessment engine (criteria catalogue integrity,
Leopold-matrix scoring, weight normalisation, the composite index, and the
recommendation tiers); if you change any of these areas, extend the tests
accordingly.

## Guidelines

- **Criteria catalogue**: new criteria must declare a unique code, dimension
  (`ENV` / `SOC` / `ECO`), Arabic name, English usage, description, and — when
  applicable — a specific action and reference entry in
  `lib/data/criteria_data.dart`. The recommendation maps must stay aligned
  with the catalogue (38 criteria, 38 specific actions, 38 specific
  references).
- **Bilingual strings**: user-facing text belongs in both string tables under
  `lib/i18n/`. An English-only or Arabic-only change will not be merged.
- **Offline-first**: do not introduce network calls, telemetry, or account
  requirements. Assessment data must never leave the device.
- **Style**: follow the standard Dart style enforced by `flutter analyze`
  (`flutter_lints`).

## Reporting issues

Open a GitHub issue with a clear title, the steps to reproduce, the expected
behaviour, and (for scoring questions) the criterion code and parameter
values involved.

## License

By contributing, you agree that your contributions will be licensed under the
MIT License that covers this project.
