# flutter_smart_home_tablet

Flutter ARS BANK Tablet Application.

## Getting Started

This is a Flutter tablet application migrated from the mobile app.

## Project Structure

```
lib/
├── main.dart              # Application entry point
├── main_app.dart          # Main app widget (to be created)
├── locator.dart           # Dependency injection setup (to be created)
├── constant/              # Constants and configurations
├── enum/                  # Enumerations
├── flavor/                # Environment and flavor configurations
├── firebase/              # Firebase configurations
├── inherit/               # Base classes
├── l10n/                  # Localization files
├── module/                # Feature modules
├── platform/              # Platform-specific utilities
├── push_notification/     # Push notification handling
├── router/                # Navigation and routing
├── services/              # Business logic services
├── ui/                    # UI components and widgets
└── utils/                 # Utility functions
```

## Architecture

This project follows a modular architecture pattern:

- **Dependency Injection**: Using GetIt for service locator pattern
- **State Management**: Using Provider with ChangeNotifier
- **Routing**: Custom routing system
- **Services**: Business logic layer
- **Modules**: Feature-based modules
- **UI**: Reusable UI components

## Development

### Prerequisites

- Flutter SDK (^3.5.0)
- Dart SDK
- FVM (Flutter Version Manager)

### Setup

```bash
fvm flutter pub get
```

### Run

```bash
fvm flutter run
```

### Build

```bash
# Android
fvm flutter build apk --release

# iOS
fvm flutter build ios --release

# Web
fvm flutter build web --release
```

## Migration Notes

This project is being migrated from `flutter-ars-bank` mobile app to tablet version. The architecture will be adapted for tablet-specific UI/UX patterns.

See [ARCHITECTURE.md](./ARCHITECTURE.md) for detailed architecture analysis.
