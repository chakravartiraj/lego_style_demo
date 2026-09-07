import SwiftUI

@main
struct LegoStyleDemoApp: App {
    var body: some Scene {
        WindowGroup {
            LegoListView()
                .preferredColorScheme(.dark)
        }
    }
}
