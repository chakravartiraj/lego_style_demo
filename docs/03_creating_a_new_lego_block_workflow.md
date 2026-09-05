# 🏗 Workflow: Creating a New Lego Block

Whenever you are tasked with building a new feature, follow this workflow to create a perfectly architected Lego Block.

## Step 1: Scaffold the Package
Navigate to the `feature/` directory and create a new Flutter package:
```bash
cd feature
flutter create --template=package feature_name
```

## Step 2: Configure `pubspec.yaml`
Delete the generated boilerplate dependencies and add the standard Lego Stack:
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.1
  get_it: ^7.2.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  core_testing:
    path: ../../core/testing
  mocktail: ^1.0.5
```

## Step 3: Architect the Block Internals
Inside your new feature package, structure the `lib/` directory using standard Clean Architecture/BLoC patterns:
- `lib/src/ui/` (Widgets, Pages)
- `lib/src/bloc/` (State Management)
- `lib/src/repository/` (Data fetching logic)

*Note: Keep internal implementation details inside `src/`. Only expose what the App Shell needs in the root `lib/feature_name.dart` file.*

## Step 4: Expose the API Boundary
In your `lib/feature_name.dart` file, export **only** the classes the App Shell needs to know about (usually just the main Page Widget and maybe a highly-abstracted Repository interface).
```dart
library feature_name;

export 'src/ui/feature_name_page.dart';
```

## Step 5: Wire it to the App Shell
Finally, navigate to `app/lego_app/pubspec.yaml` and add your new feature as a dependency:
```yaml
dependencies:
  feature_name:
    path: ../../feature/feature_name
```
Then, register its routes in the app's `GoRouter` configuration and inject any required Repositories via `GetIt` in the app's dependency injection setup.
