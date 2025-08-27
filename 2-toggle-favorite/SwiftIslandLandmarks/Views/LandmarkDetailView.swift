import AppIntents
import SwiftUI
import SwiftData

struct LandmarkDetailView: View {
	@Environment(\.dismiss) var dismiss
	@Environment(\.modelContext) var modelContext
	
	@State private var isEditLandmarkShowing = false
	@State private var isSelectCollectionsShowing = false
	@State private var isAddVisitShowing = false
	@State private var isEditVisitShowing: Visit?

	@Binding var navigationContext: NavigationContext
	
	var body: some View {
		Group {
			if let landmark = navigationContext.selectedLandmark {
				List {
					Section("Visits") {
						ForEach(landmark.visits) { visit in
							VStack(alignment: .leading) {
								Text(visit.timestamp.formatted(date: .abbreviated, time: .omitted))
									.font(.caption)
								Text(visit.log)
									.frame(maxWidth: .infinity, alignment: .leading)
							}
							.swipeActions {
								Button("Edit") {
									isEditVisitShowing = visit
								}
							}
						}
						Button("Add a visit", systemImage: "plus") {
							isAddVisitShowing.toggle()
						}
					}
					
					Section("In collections") {
						ForEach(landmark.collections) { collection in
							Text(collection.name)
								.swipeActions(edge: .trailing) {
									Button("Remove", role: .destructive) {
										landmark.collections.removeAll { $0.id == collection.id }
									}
								}
						}
						Button("Add to collection", systemImage: "plus") {
							isSelectCollectionsShowing.toggle()
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
						// ⭐️ Bonus points! You can use intents in your regular code as well.
						Button(action: {
							landmark.isFavorite.toggle()
						}) {
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
				.sheet(item: $isEditVisitShowing) { visit in
					EditVisitForm(
						landmark: landmark,
						visit: visit,
						deleteHandler: {}
					)
				}
				.sheet(isPresented: $isAddVisitShowing) {
					EditVisitForm(
						landmark: landmark,
						visit: nil,
						deleteHandler: {}
					)
				}
				.sheet(isPresented: $isSelectCollectionsShowing) {
					SelectCollectionsView(landmark: landmark)
				}
			} else {
				ContentUnavailableView(
					"Select a landmark",
					systemImage: "photo",
					description: Text("Pick a landmark from a collection.")
				)
			}
		}
	}
}
