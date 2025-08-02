import SwiftData
import SwiftUI

struct SelectCollectionsView: View {
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext
	
	@Query private var collections: [LandmarkCollection]
	
	let landmark: Landmark
	
	var body: some View {
		NavigationStack {
			Group {
				if collections.isEmpty {
					Text("Nothing to select. You should create some.")
				} else {
					List {
						ForEach(collections) { collection in
							Button {
								addOrRemove(collection: collection, from: landmark)
							} label: {
								HStack {
									Text(collection.name)
										.frame(maxWidth: .infinity, alignment: .leading)
									if landmark.collections.contains(collection) {
										Image(systemName: "checkmark")
									}
								}
							}
						}
					}
				}
			}
			.navigationTitle("Edit collections")
			.toolbar {
				ToolbarItem(placement: .confirmationAction) {
					Button("Done") {
						dismiss()
					}
				}
			}
		}
	}
}

extension SelectCollectionsView {
	func addOrRemove(collection: LandmarkCollection, from landmark: Landmark) {
		if landmark.collections.contains(collection) {
			remove(collection: collection, from: landmark)
		} else {
			add(collection: collection, to: landmark)
		}
	}

	func add(collection: LandmarkCollection, to landmark: Landmark) {
		landmark.collections.append(collection)
	}

	func remove(collection: LandmarkCollection, from landmark: Landmark) {
		landmark.collections.removeAll { $0.id == collection.id }
	}
}
