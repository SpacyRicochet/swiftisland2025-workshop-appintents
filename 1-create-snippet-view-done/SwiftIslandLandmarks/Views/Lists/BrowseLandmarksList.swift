import SwiftData
import SwiftUI

struct BrowseLandmarksList: View {
	@Environment(\.modelContext) private var modelContext
	
	@Query(sort: \Landmark.name) private var landmarks: [Landmark]
	
	@State private var isEditorPresented = false
	@Binding var navigationContext: NavigationContext
	
	var body: some View {
		List(selection: $navigationContext.selectedLandmark) {
			ForEach(landmarks) { landmark in
				NavigationLink(landmark.name, value: landmark)
			}
			.onDelete(perform: deleteItems)
			Button(action: addItem) {
				Label("Add Landmark", systemImage: "plus")
			}
			.disabled(isEditorPresented)
		}
		.listStyle(.insetGrouped)
		.navigationTitle("Browse")
	}
}

extension BrowseLandmarksList {
	private func addItem() {
		isEditorPresented.toggle()
	}
	
	private func deleteItems(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				modelContext.delete(landmarks[index])
			}
		}
	}
}
