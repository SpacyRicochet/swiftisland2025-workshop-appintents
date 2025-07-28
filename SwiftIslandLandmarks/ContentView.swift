import SwiftUI
import SwiftData

struct ContentView: View {
	@Environment(\.modelContext) private var modelContext
	@Query private var landmarks: [Landmark]
	@Query private var collections: [LandmarkCollection]
	
	var body: some View {
		NavigationSplitView {
			List {
				Section {
					ForEach(landmarks) { landmark in
						NavigationLink {
							NavigationStack {
								LandmarkDetailView(landmark: landmark)
							}
						} label: {
							Text(landmark.name)
						}
					}
					.onDelete(perform: deleteItems)
					Button(action: addItem) {
						Label("Add Landmark", systemImage: "plus")
					}
				} header: {
					Label("Landmarks", systemImage: "photo")
				}
				
				Section {
					ForEach(collections) { collection in
						NavigationLink {
							NavigationStack {
								LandmarkCollectionDetailView(collection: collection)
							}
						} label: {
							Text(collection.name)
						}
					}
					Button(action: addItem) {
						Label("Add Collection", systemImage: "plus")
					}
				} header: {
					Label("Collections", systemImage: "photo.stack")
				}
			}
			.listStyle(.insetGrouped)
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					EditButton()
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
			let newItem = Landmark.texel
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
		.modelContainer(try! ModelContainer.sample())
}
