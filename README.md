# WIA — Water Impact Assessment

A bilingual (Arabic / English) Flutter application for structured,
criteria-based assessment of water projects. WIA guides the assessor through
a complete workflow — project identification, data-entry forms for each
assessment dimension, configurable criterion weights, and a consolidated
results dashboard — entirely offline, with all data stored on the device.

## Features

- **Bilingual interface** — one-tap switching between Arabic and English
- **Guided workflow** — project info → dimension forms → results dashboard
- **Weighted criteria** — adjustable criterion weights (weight settings
  screen) over a built-in criteria catalogue (`lib/data/criteria_data.dart`)
- **Offline-first** — no accounts, no servers; assessment data never leaves
  the device
- **CI-built APK** — release builds produced automatically by GitHub Actions

## Project structure

```
lib/
├── main.dart              # app entry + language state
├── i18n/                  # Arabic / English string tables
├── models/                # data models
├── data/                  # assessment criteria catalogue
├── screens/               # dashboard, project info, dimension forms,
│                          # results, weight settings, about
└── widgets/               # shared UI components
```

## Building

Requirements: Flutter SDK >= 3.10 (Dart >= 3.0).

```bash
flutter pub get
flutter run                  # development
flutter build apk --release  # release APK
```

## License

MIT — see [LICENSE](LICENSE).
