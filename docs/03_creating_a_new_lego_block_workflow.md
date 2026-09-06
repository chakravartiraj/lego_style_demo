# 🏗 Workflow: Creating a New Lego Block

Whenever you are tasked with building a new feature, follow this workflow to create a perfectly architected Lego Block in the Android Gradle environment.

## Step 1: Scaffold the Module
Navigate to the `feature/` directory and create a new Android Library module (or use the Android Studio UI: File -> New -> New Module -> Android Library).
```bash
mkdir -p feature/feature_name/src/main/java/com/example/lego/feature/featurename
```

## Step 2: Configure `build.gradle.kts`
Inside your new feature module, create the `build.gradle.kts` and add the standard Lego Stack:
```kotlin
plugins {
    id("com.android.library")
    id("org.jetbrains.kotlin.android")
    // id("com.google.dagger.hilt.android") // Add when Hilt is enabled
}

android {
    namespace = "com.example.lego.feature.featurename"
    // ... basic android config
    buildFeatures { compose = true }
}

dependencies {
    implementation(project(":core:design_system"))
    
    // Compose
    implementation(platform("androidx.compose:compose-bom:2024.02.01"))
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.material3:material3")
    
    // ViewModel & Hilt
    implementation("androidx.lifecycle:lifecycle-viewmodel-compose:2.7.0")
    // implementation("com.google.dagger:hilt-android:2.51")
}
```

## Step 3: Architect the Block Internals
Inside your new feature package (`src/main/java/com/.../featurename/`), structure the code using standard Clean Architecture/MVVM patterns:
- `ui/` (Compose Screens, ViewModels)
- `domain/` (Use Cases, Domain Models)
- `data/` (Repositories, DTOs, API Interfaces)

*Note: Keep internal implementation details package-private or `internal`. Only expose what the App Shell needs in the root of the module.*

## Step 4: Expose the API Boundary
In your feature module, export **only** the Composables or interfaces the App Shell needs to know about (usually just the main Screen Composable).
```kotlin
package com.example.lego.feature.featurename

import androidx.compose.runtime.Composable

@Composable
fun FeatureNameScreen(viewModel: FeatureNameViewModel = hiltViewModel()) {
    // Implementation details hidden inside module
}
```

## Step 5: Wire it to the App Shell
Finally, navigate to `app/build.gradle.kts` and add your new feature as a dependency:
```kotlin
dependencies {
    implementation(project(":feature:feature_name"))
}
```
Then, register its routes in the app's `NavHost` configuration and ensure any required Hilt modules are installed in `SingletonComponent` within `:app`.
