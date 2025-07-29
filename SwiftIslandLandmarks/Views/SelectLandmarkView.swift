import SwiftData
import SwiftUI

struct SelectLandmarkView: View {
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) private var modelContext
	
	@Query private var landmarks: [Landmark]
	
	let collection: LandmarkCollection
	let handler: (Landmark) -> Void
	
	var body: some View {
		NavigationStack {
			Group {
				if landmarks.isEmpty {
					Text("Nothing to select.")
				} else {
					List {
						ForEach(landmarks) { landmark in
							Button(landmark.name) {
								handler(landmark)
								dismiss()
							}
							.disabled(collection.landmarks.contains(landmark))
						}
					}
				}
			}
			.navigationTitle("Select a landmark")
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel") {
						dismiss()
					}
				}
			}
		}
	}
}
