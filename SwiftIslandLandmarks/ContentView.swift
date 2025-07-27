import SwiftUI
import SwiftData

struct ContentView: View {
	@Environment(\.modelContext) private var modelContext
	@Query private var landmarks: [Landmark]
	
	var body: some View {
		NavigationSplitView {
			List {
				ForEach(landmarks) { landmark in
					NavigationLink {
						LandmarkDetailView(landmark: landmark)
					} label: {
						Text(landmark.name)
					}
				}
				.onDelete(perform: deleteItems)
			}
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					EditButton()
				}
				ToolbarItem {
					Button(action: addItem) {
						Label("Add Item", systemImage: "plus")
					}
				}
			}
		} detail: {
			NavigationStack {
				Text("Select an item")
			}
		}
	}
	
	private func addItem() {
		withAnimation {
			let newItem = Landmark.texel()
			modelContext.insert(newItem)
		}
	}
	
	private func deleteItems(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				modelContext.delete(landmarks[index])
			}
		}
	}
}

#Preview {
	ContentView()
		.modelContainer(for: Landmark.self, inMemory: true)
}
