import SwiftData
import SwiftUI

struct FavoritesList: View {
	@Query(
		filter: Landmark.favoritesPredicate,
		sort: \Landmark.name
	)
	private var favorites: [Landmark]
	@Binding var navigationContext: NavigationContext
	
	var body: some View {
		Group {
			if favorites.isEmpty {
				ContentUnavailableView(
					"No favorites yet?",
					systemImage: "star.slash",
					description: Text("When you visit a great landmark, make sure to tag it as a favorite.")
				)
			} else {
				List(selection: $navigationContext.selectedLandmark) {
					ForEach(favorites) { landmark in
						NavigationLink(landmark.name, value: landmark)
							.swipeActions(edge: .trailing) {
								Button("Remove", systemImage: "star.slash") {
									landmark.isFavorite = false
								}
								.tint(.yellow)
							}
					}
				}
				.listStyle(.insetGrouped)
			}
		}
		.navigationTitle("⭐️ Favorites")
	}
}
