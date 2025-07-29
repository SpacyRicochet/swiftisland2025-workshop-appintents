import SwiftData
import SwiftUI

struct MainOverview: View {
	@Environment(\.modelContext) private var modelContext
	
	@Query private var landmarks: [Landmark]
	@Query private var collections: [LandmarkCollection]
	
	@State private var isEditorPresented = false
	
	var body: some View {
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
				.disabled(isEditorPresented)
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
		.sheet(isPresented: $isEditorPresented) {
			EditLandmarkForm(landmark: nil, deleteHandler: nil)
		}
	}
}

extension MainOverview {
	private func addItem() {
		isEditorPresented.toggle()
//		withAnimation {
//			let newItem = Landmark.texel
//			modelContext.insert(newItem)
//		}
	}
	
	private func deleteItems(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				modelContext.delete(landmarks[index])
			}
		}
	}
}
