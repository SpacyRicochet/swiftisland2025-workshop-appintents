import SwiftUI
import SwiftData

struct LandmarkDetailView: View {
	@Environment(\.dismiss) var dismiss
	
	@State private var isEditLandmarkShowing = false
	@State private var isSelectCollectionsShowing = false
	
	let landmark: Landmark
	
	var body: some View {
		List {
			Section {
				ForEach(landmark.visits) { visit in
					Text(visit.timestamp.formatted(date: .abbreviated, time: .omitted))
						.swipeActions {
							Button("Remove", role: .destructive) {
								landmark.visits.removeAll { $0.id == visit.id }
							}
						}
				}
			} header: {
				HStack {
					Text("Visits")
						.frame(maxWidth: .infinity, alignment: .leading)
					Button("Add a visit", systemImage: "plus") {
						landmark.visits.append(Visit(timestamp: Date()))
					}
				}
			}
			
			Section {
				ForEach(landmark.collections) { collection in
					Text(collection.name)
						.swipeActions(edge: .trailing) {
							Button("Remove", role: .destructive) {
								landmark.collections.removeAll { $0.id == collection.id }
							}
						}
				}
			} header: {
				HStack {
					Text("In collections")
						.frame(maxWidth: .infinity, alignment: .leading)
					Button("Add to collection", systemImage: "plus") {
						isSelectCollectionsShowing.toggle()
					}
				}
			}
		}
		.navigationTitle(landmark.name)
		.toolbar {
			ToolbarItem(placement: .topBarTrailing) {
				Button("Edit") {
					isEditLandmarkShowing.toggle()
				}
			}
			ToolbarItem(placement: .topBarTrailing) {
				Button {
					landmark.isFavorite.toggle()
				} label: {
					Label(
						landmark.isFavorite ? "Remove from favorites" : "Add to favorites",
						systemImage: landmark.isFavorite ? "star.fill" : "star"
					)
						.labelStyle(.iconOnly)
				}
				.tint(.yellow)
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
		.sheet(isPresented: $isSelectCollectionsShowing) {
			SelectCollectionsView(landmark: landmark)
		}
	}
}
