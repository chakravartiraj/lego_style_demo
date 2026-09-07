import SwiftUI

struct DragonBallView: View {
    @StateObject private var viewModel = DragonBallViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.characters) { character in
                    NavigationLink(destination: DragonBallDetailsView(characterId: character.id, viewModel: viewModel)) {
                        DBCharacterCard(character: character)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Dragon Ball-Z Universe")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.black.ignoresSafeArea())
    }
}

struct DBCharacterCard: View {
    let character: DBCharacter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(character.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(character.race)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.darkGray))
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

struct DragonBallDetailsView: View {
    let characterId: String
    @ObservedObject var viewModel: DragonBallViewModel
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            if let character = viewModel.getCharacterById(id: characterId) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Name: \(character.name)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("Race: \(character.race)")
                        .font(.title3)
                        .foregroundColor(.gray)
                    Text("Voice Actor: \(character.voiceActor)")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(UIColor.darkGray))
                .cornerRadius(12)
                .padding()
                
                Spacer()
            } else {
                Text("Character not found")
                    .foregroundColor(.red)
            }
        }
        .navigationTitle(viewModel.getCharacterById(id: characterId)?.name ?? "Unknown")
        .navigationBarTitleDisplayMode(.inline)
    }
}
