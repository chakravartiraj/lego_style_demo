import SwiftUI

struct STCharacter: Identifiable {
    let id: String
    let name: String
    let rank: String
    let actor: String
}

class StarTrekViewModel: ObservableObject {
    @Published var characters: [STCharacter] = []
    
    init() {
        characters = [
            STCharacter(id: "1", name: "James T. Kirk", rank: "Captain", actor: "William Shatner"),
            STCharacter(id: "2", name: "Spock", rank: "Commander", actor: "Leonard Nimoy"),
            STCharacter(id: "3", name: "Leonard McCoy", rank: "Lieutenant Commander", actor: "DeForest Kelley"),
            STCharacter(id: "4", name: "Nyota Uhura", rank: "Lieutenant", actor: "Nichelle Nichols"),
            STCharacter(id: "5", name: "Hikaru Sulu", rank: "Lieutenant", actor: "George Takei")
        ]
    }
    
    func getCharacterById(id: String) -> STCharacter? {
        characters.first { $0.id == id }
    }
}
