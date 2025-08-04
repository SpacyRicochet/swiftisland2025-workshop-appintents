import SwiftData
import SwiftUI

struct FavoritesView: View {
	@Query(
		filter: Landmark.favoritesPredicate,
		sort: \.name
	)
	var favorites: [Landmark]
	
	var body: some View {
		List {
			ForEach(favorites) { landmark in
				NavigationLink {
					LandmarkDetailView(landmark: landmark)
				} label: {
					Text(landmark.name)
				}
				.swipeActions(edge: .trailing) {
					Button("Remove from favorites", systemImage: "star.slash") {
						landmark.isFavorite = false
					}
					.tint(.yellow)
				}
			}
		}
		.navigationTitle("⭐️ Favorites")
	}
}
