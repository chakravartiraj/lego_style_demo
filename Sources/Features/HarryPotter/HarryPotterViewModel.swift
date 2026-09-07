import SwiftUI

struct HPCharacter: Identifiable {
    let id: String
    let name: String
    let house: String
    let actor: String
}

class HarryPotterViewModel: ObservableObject {
    @Published var characters: [HPCharacter] = []
    
    init() {
        characters = [
            HPCharacter(id: "1", name: "Harry Potter", house: "Gryffindor", actor: "Daniel Radcliffe"),
            HPCharacter(id: "2", name: "Hermione Granger", house: "Gryffindor", actor: "Emma Watson"),
            HPCharacter(id: "3", name: "Ron Weasley", house: "Gryffindor", actor: "Rupert Grint"),
            HPCharacter(id: "4", name: "Draco Malfoy", house: "Slytherin", actor: "Tom Felton"),
            HPCharacter(id: "5", name: "Severus Snape", house: "Slytherin", actor: "Alan Rickman")
        ]
    }
    
    func getCharacterById(id: String) -> HPCharacter? {
        characters.first { $0.id == id }
    }
}
