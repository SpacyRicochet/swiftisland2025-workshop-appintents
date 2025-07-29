import SwiftUI
import SwiftData

struct LandmarkDetailView: View {
	@Environment(\.dismiss) var dismiss
	@State private var isEditLandmarkShowing = false
	
	let landmark: Landmark
	
	var body: some View {
		VStack {
			HStack {
				Text(landmark.name)
					.font(.title)
			}
			if let lastVisited = landmark.lastVisited {
				VStack(spacing: 4) {
					Text("Last visited")
					Text(lastVisited.formatted(date: .abbreviated, time: .omitted))
				}
			} else {
				Button {
					landmark.lastVisited = Date()
				} label: {
					Text("Add a visit")
				}
			}
		}
		.navigationTitle(landmark.name)
		.toolbar {
			ToolbarItem(placement: .secondaryAction) {
				Button(
					landmark.isFavorite ? "Remove from favorites" : "Add to favorites",
					systemImage: landmark.isFavorite ? "heart.slash" : "heart") {
						landmark.isFavorite.toggle()
					}
					.tint(.red)
			}
			ToolbarItem(placement: .topBarTrailing) {
				Button("Edit") {
					isEditLandmarkShowing.toggle()
				}
			}
		}
		.sheet(isPresented: $isEditLandmarkShowing) {
			EditLandmarkForm(
				landmark: landmark,
				deleteHandler: {
					dismiss()
				}
			)
		}
	}
}
