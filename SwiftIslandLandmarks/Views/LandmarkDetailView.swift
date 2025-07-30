import SwiftUI
import SwiftData

struct LandmarkDetailView: View {
	@Environment(\.dismiss) var dismiss
	@State private var isEditLandmarkShowing = false
	
	let landmark: Landmark
	
	var body: some View {
		List {
			Section("Visits") {
				if let lastVisited = landmark.lastVisited {
					VStack(spacing: 4) {
						Text("Last visited: \(lastVisited.formatted(date: .abbreviated, time: .omitted))")
					}
				}
				Button {
					landmark.visits.append(Visit(timestamp: Date(), landmark: landmark))
				} label: {
					Text("Add a visit")
				}
			}
			
			if let collection = landmark.collection {
				Section("In collection") {
					Text(collection.name)
						.swipeActions(edge: .trailing) {
							Button("Remove", role: .destructive) {
								landmark.collection = nil
							}
						}
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
