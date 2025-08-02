import SwiftData
import SwiftUI

struct SelectLandmarksView: View {
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext
	
	@Query private var landmarks: [Landmark]
	
	let collection: LandmarkCollection
	
	var body: some View {
		NavigationStack {
			Group {
				if landmarks.isEmpty {
					Text("Nothing to select. You should create some.")
				} else {
					List {
						ForEach(landmarks) { landmark in
							Button {
								if collection.landmarks.contains(landmark) {
									collection.landmarks.removeAll { $0.id == landmark.id }
								} else {
									collection.landmarks.append(landmark)
								}
							} label: {
								HStack {
									Text(landmark.name)
										.frame(maxWidth: .infinity, alignment: .leading)
									if collection.landmarks.contains(landmark) {
										Image(systemName: "checkmark")
									}
								}
							}
						}
					}
				}
			}
			.navigationTitle("Select a landmark")
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
