import SwiftUI

struct HarryPotterView: View {
    @StateObject private var viewModel = HarryPotterViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.characters) { character in
                    NavigationLink(destination: HarryPotterDetailsView(characterId: character.id, viewModel: viewModel)) {
                        HPCharacterCard(character: character)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Harry Potter Universe")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.black.ignoresSafeArea())
    }
}

struct HPCharacterCard: View {
    let character: HPCharacter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(character.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(character.house)
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

struct HarryPotterDetailsView: View {
    let characterId: String
    @ObservedObject var viewModel: HarryPotterViewModel
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            if let character = viewModel.getCharacterById(id: characterId) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Name: \(character.name)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("House: \(character.house)")
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
