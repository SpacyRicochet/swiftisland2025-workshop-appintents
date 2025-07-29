import SwiftData
import SwiftUI

struct LandmarkCollectionDetailView: View {
	@Environment(\.modelContext) var modelContext
	let collection: LandmarkCollection
	
	@State private var isAddLandmarkPresented = false
	
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
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button("Add landmark") {
					isAddLandmarkPresented.toggle()
				}
			}
		}
		.sheet(isPresented: $isAddLandmarkPresented) {
			SelectLandmarkView(collection: collection) {
				collection.landmarks.append($0)
			}
		}
	}
}
