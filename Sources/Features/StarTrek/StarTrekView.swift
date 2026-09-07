import SwiftUI

struct StarTrekView: View {
    @StateObject private var viewModel = StarTrekViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.characters) { character in
                    NavigationLink(destination: StarTrekDetailsView(characterId: character.id, viewModel: viewModel)) {
                        STCharacterCard(character: character)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Star Trek Universe")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.black.ignoresSafeArea())
    }
}

struct STCharacterCard: View {
    let character: STCharacter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(character.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(character.rank)
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

struct StarTrekDetailsView: View {
    let characterId: String
    @ObservedObject var viewModel: StarTrekViewModel
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            if let character = viewModel.getCharacterById(id: characterId) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Name: \(character.name)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("Rank: \(character.rank)")
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
