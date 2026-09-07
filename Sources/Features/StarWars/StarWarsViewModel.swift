import SwiftUI

struct SWCharacter: Identifiable {
    let id: String
    let name: String
    let affiliation: String
    let actor: String
}

class StarWarsViewModel: ObservableObject {
    @Published var characters: [SWCharacter] = []
    
    init() {
        characters = [
            SWCharacter(id: "1", name: "Luke Skywalker", affiliation: "Jedi / Rebellion", actor: "Mark Hamill"),
            SWCharacter(id: "2", name: "Darth Vader", affiliation: "Sith / Empire", actor: "David Prowse / James Earl Jones"),
            SWCharacter(id: "3", name: "Han Solo", affiliation: "Rebellion", actor: "Harrison Ford"),
            SWCharacter(id: "4", name: "Leia Organa", affiliation: "Rebellion", actor: "Carrie Fisher"),
            SWCharacter(id: "5", name: "Yoda", affiliation: "Jedi", actor: "Frank Oz")
        ]
    }
    
    func getCharacterById(id: String) -> SWCharacter? {
        characters.first { $0.id == id }
    }
}
