import SwiftUI

struct LegoUniverse: Identifiable {
    let id: String
    let name: String
    let isAvailable: Bool
}

class LegoListViewModel: ObservableObject {
    @Published var universes: [LegoUniverse] = []
    
    init() {
        universes = [
            LegoUniverse(id: "harry_potter", name: "Harry Potter Universe", isAvailable: true),
            LegoUniverse(id: "star_wars", name: "Star Wars Universe", isAvailable: true),
            LegoUniverse(id: "star_trek", name: "Star Trek Universe", isAvailable: true),
            LegoUniverse(id: "dragon_ball", name: "Dragon Ball-Z Universe", isAvailable: true)
        ]
    }
}
