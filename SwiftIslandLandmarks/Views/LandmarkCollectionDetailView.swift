import SwiftData
import SwiftUI

struct LandmarkCollectionDetailView: View {
	@Environment(\.modelContext) var modelContext
	let collection: LandmarkCollection
	
	var body: some View {
		List {
			ForEach(collection.landmarks) { landmark in
				NavigationLink {
					LandmarkDetailView(landmark: landmark)
				} label: {
					Text(landmark.name)
				}
			}
		}
		.navigationBarTitle(collection.name)
	}
}
