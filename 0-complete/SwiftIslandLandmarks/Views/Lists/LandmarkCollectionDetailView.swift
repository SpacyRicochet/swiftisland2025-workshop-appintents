import SwiftData
import SwiftUI

struct LandmarkCollectionDetailView: View {
	@Environment(\.modelContext) private var modelContext
	
	@State private var isSelectLandmarksPresented = false
	@Binding var navigationContext: NavigationContext
	
	var body: some View {
		if let collection = navigationContext.selectedCollection {
			switch collection.name {
				case LandmarkCollection.browse.name:
					BrowseLandmarksList(navigationContext: $navigationContext)
				case LandmarkCollection.favorites.name:
					FavoritesList(navigationContext: $navigationContext)
				default:
					List(selection: $navigationContext.selectedLandmark) {
						ForEach(collection.landmarks) { landmark in
							NavigationLink(landmark.name, value: landmark)
						}
						Button("Edit landmarks", systemImage: "pencil") {
							isSelectLandmarksPresented.toggle()
						}
					}
					.listStyle(.insetGrouped)
					.navigationBarTitle(collection.name)
					.sheet(isPresented: $isSelectLandmarksPresented) {
						SelectLandmarksView(collection: collection)
					}
			}
		} else {
			ContentUnavailableView(
				"Select a collection",
				systemImage: "photo.stack",
				description: Text("Pick a collection from the list.")
			)
		}
	}
}
