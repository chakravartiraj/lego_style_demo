import SwiftUI

struct LegoListView: View {
    @StateObject private var viewModel = LegoListViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.universes) { universe in
                        NavigationLink(value: universe.id) {
                            LegoWorldCard(universe: universe)
                        }
                        .disabled(!universe.isAvailable)
                    }
                }
                .padding()
            }
            .navigationTitle("Lego Worlds")
            .background(Color.black.ignoresSafeArea())
            .navigationDestination(for: String.self) { id in
                switch id {
                case "harry_potter":
                    HarryPotterView()
                case "star_wars":
                    StarWarsView()
                case "star_trek":
                    StarTrekView()
                case "dragon_ball":
                    DragonBallView()
                default:
                    Text("Unknown Universe").foregroundColor(.white)
                }
            }
        }
        .tint(.white) // Back button color
    }
}

struct LegoWorldCard: View {
    let universe: LegoUniverse
    
    var body: some View {
        VStack(spacing: 8) {
            Text(universe.name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            if !universe.isAvailable {
                Text("(Coming Soon)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color(UIColor.darkGray).opacity(universe.isAvailable ? 1.0 : 0.5))
        .cornerRadius(16)
        .shadow(radius: 8)
    }
}
