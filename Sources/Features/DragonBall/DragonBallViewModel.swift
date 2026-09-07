import SwiftUI

struct DBCharacter: Identifiable {
    let id: String
    let name: String
    let race: String
    let voiceActor: String
}

class DragonBallViewModel: ObservableObject {
    @Published var characters: [DBCharacter] = []
    
    init() {
        characters = [
            DBCharacter(id: "1", name: "Goku", race: "Saiyan", voiceActor: "Sean Schemmel"),
            DBCharacter(id: "2", name: "Vegeta", race: "Saiyan", voiceActor: "Christopher Sabat"),
            DBCharacter(id: "3", name: "Piccolo", race: "Namekian", voiceActor: "Christopher Sabat"),
            DBCharacter(id: "4", name: "Gohan", race: "Half-Saiyan", voiceActor: "Kyle Hebert"),
            DBCharacter(id: "5", name: "Frieza", race: "Frieza Race", voiceActor: "Daman Mills")
        ]
    }
    
    func getCharacterById(id: String) -> DBCharacter? {
        characters.first { $0.id == id }
    }
}
