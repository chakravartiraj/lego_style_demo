# 🏗 Workflow: Creating a New Lego Block

Whenever you are tasked with building a new feature, follow this workflow to create a perfectly architected Lego Block in the iOS environment.

## Step 1: Scaffold the Directory
Navigate to the `Sources/Features/` directory and create a new folder for your feature.
```bash
mkdir -p Sources/Features/NewFeature
```

## Step 2: Configure `project.yml`
Open `project.yml` at the root of the project. If you are separating features by actual Xcode targets, define your new target here. (Alternatively, if using a single target monorepo approach, ensure the source files are tracked under the main target).

```yaml
targets:
  LegoStyleDemo:
    type: application
    platform: iOS
    deploymentTarget: "17.0"
    sources: [Sources]
```

## Step 3: Architect the Block Internals
Inside your new feature folder (`Sources/Features/NewFeature/`), structure the code using standard MVVM patterns:
- `NewFeatureView.swift` (SwiftUI Screen)
- `NewFeatureViewModel.swift` (ObservableObject)
- `NewFeatureRepository.swift` (Data layer)

*Note: Keep internal implementation details `private` or `internal` (default in Swift). Only expose what the App Shell needs public.*

## Step 4: Expose the API Boundary
In your feature module, export **only** the Views or interfaces the App Shell needs to know about.
```swift
import SwiftUI

public struct NewFeatureView: View {
    @StateObject private var viewModel: NewFeatureViewModel
    
    public init(repository: NewFeatureRepositoryProtocol) {
        _viewModel = StateObject(wrappedValue: NewFeatureViewModel(repository: repository))
    }
    
    public var body: some View {
        // Implementation details hidden inside module
        Text("Hello New Feature")
    }
}
```

## Step 5: Wire it to the App Shell
Finally, navigate to `Sources/App/LegoStyleDemoApp.swift` (or your router) and add your new feature to the `NavigationStack`:
```swift
NavigationLink("Go to New Feature", value: Route.newFeature)
```
Then, register its route in the `.navigationDestination(for:)` block.
