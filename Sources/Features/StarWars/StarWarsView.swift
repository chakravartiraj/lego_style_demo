import SwiftUI

struct StarWarsView: View {
    @StateObject private var viewModel = StarWarsViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.characters) { character in
                    NavigationLink(destination: StarWarsDetailsView(characterId: character.id, viewModel: viewModel)) {
                        SWCharacterCard(character: character)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Star Wars Universe")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.black.ignoresSafeArea())
    }
}

struct SWCharacterCard: View {
    let character: SWCharacter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(character.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(character.affiliation)
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

struct StarWarsDetailsView: View {
    let characterId: String
    @ObservedObject var viewModel: StarWarsViewModel
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            if let character = viewModel.getCharacterById(id: characterId) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Name: \(character.name)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("Affiliation: \(character.affiliation)")
                        .font(.title3)
                        .foregroundColor(.gray)
                    Text("Played by: \(character.actor)")
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
