# TaskFlow

TaskFlow is a responsive Flutter task-management application for creating, organizing, searching, filtering, and completing daily tasks. It uses a calm, focused workspace design with light and dark themes, local-first storage, and a consistent design system.

## Features

- Create tasks with a title, description, and optional due date.
- Edit and delete existing tasks.
- Mark tasks as complete or pending.
- Search by task title or description.
- Filter tasks by All, Pending, or Completed.
- View task counts and completion progress.
- See due-date, overdue, and completion status badges.
- Switch between light and dark mode.
- Persist the selected theme between app launches.
- Store task data locally with Hive.
- Use a responsive layout with a desktop/tablet sidebar and mobile navigation.
- Use accessible labels, tooltips, and touch targets for primary actions.

## Technology

- Flutter and Dart
- Material 3
- BLoC/Cubit state management
- Hive for local task storage
- SharedPreferences for theme persistence
- Local Plus Jakarta Sans font assets

## Architecture

TaskFlow separates presentation, state, data access, and persistence:

```text
Presentation widgets and screens
              ↓
          TaskCubit
              ↓
      TaskRepository interface
              ↓
   HiveTaskRepository + Hive
              ↓
        Local task storage
```

The UI communicates with the `TaskCubit`, which coordinates repository operations and exposes loading, success, and failure states. The repository interface keeps the task state independent from Hive so it can be replaced with another storage implementation.

## Project Structure

```text
lib/
├── app/
│   └── task_app.dart
├── core/
│   ├── storage/
│   │   └── theme_preferences.dart
│   ├── theme/
│   │   ├── app_layout.dart
│   │   ├── app_palette.dart
│   │   ├── app_semantic_colors.dart
│   │   ├── app_shadows.dart
│   │   ├── app_theme.dart
│   │   ├── app_typography.dart
│   │   └── design_tokens.dart
│   ├── utils/
│   │   └── date_formatter.dart
│   └── widgets/
│       ├── app_mark.dart
│       ├── app_surface.dart
│       ├── responsive_content.dart
│       └── status_badge.dart
├── cubit/
│   ├── task_cubit.dart
│   └── task_state.dart
├── data/
│   ├── local/
│   │   └── task_adapter.dart
│   └── repositories/
│       ├── hive_task_repository.dart
│       └── task_repository.dart
├── features/
│   └── tasks/
│       └── presentation/
│           ├── screens/
│           │   ├── add_task_screen.dart
│           │   └── home_screen.dart
│           └── widgets/
│               ├── task_card.dart
│               ├── task_dashboard_view.dart
│               ├── task_date_field.dart
│               ├── task_empty_state.dart
│               ├── task_filter.dart
│               ├── task_filter_navigation.dart
│               ├── task_form_field.dart
│               ├── task_page_header.dart
│               ├── task_search_field.dart
│               ├── task_sidebar.dart
│               └── task_summary_card.dart
├── main.dart
└── models/
    └── task_model.dart
```

## Task Model

Each task contains:

- A unique ID
- Title
- Description
- Creation date
- Optional due date
- Completion status

Due dates are normalized to date-only values. Task models support value equality and safe copying for updates, including clearing an existing due date.

## Local Persistence

TaskFlow initializes Hive during startup and stores tasks in the `tasks` box. The selected theme is stored separately through SharedPreferences and restored before the first frame.

No account or network connection is required to use the application.

## Design System

The visual system is centralized under `lib/core/theme/`:

- `AppPalette` defines the approved light and dark color palettes.
- `AppTypography` applies Plus Jakarta Sans with consistent weights and text scales.
- `AppSpacing`, `AppRadii`, and `AppDimensions` define reusable layout values.
- `AppSemanticColors` provides success, warning, error, and information states.
- `AppShadows` provides theme-aware elevation styles.
- `AppTheme` assembles the Material 3 component themes.

The primary visual language uses indigo and teal accents, soft surfaces, restrained borders, rounded components, and subtle elevation.

## Branding

TaskFlow uses a purple-to-teal gradient mark with a white check and a small teal accent.

- In-app mark: `lib/core/widgets/app_mark.dart`
- Android launcher icons: `android/app/src/main/res/mipmap-*/ic_launcher.png`
- iOS launcher icons: `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

The application name is configured in the Flutter app shell, Android manifest, and iOS bundle metadata.

## Getting Started

### Prerequisites

Install the following tools:

- Flutter SDK
- Dart SDK included with Flutter
- Android Studio or an Android SDK for Android builds
- Xcode and CocoaPods for iOS builds on macOS

### Clone the Repository

```bash
git clone https://github.com/nouranagiy/task-manager-flutter.git
cd task-manager-flutter
```

### Install Dependencies

```bash
flutter pub get
```

### Run the Application

```bash
flutter run
```

Choose a connected device when Flutter prompts for one.

## Quality Checks

Run the analyzer:

```bash
flutter analyze
```

Run the test suite:

```bash
flutter test
```

Build a debug Android package:

```bash
flutter build apk --debug
```

The formatted Dart sources can be checked with:

```bash
dart format --set-exit-if-changed lib test
```

## Author

**Nora Nagiy**

Flutter Developer
