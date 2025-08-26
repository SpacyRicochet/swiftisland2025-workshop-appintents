import SwiftData
import SwiftUI

struct MainOverview: View {
	@Environment(\.modelContext) private var modelContext
	
	@Query private var collections: [LandmarkCollection]
	
	@State private var isEditorPresented = false
	@State private var isResetSampleDataPresented = false
	@Binding var navigationContext: NavigationContext
	
	var body: some View {
		List(selection: $navigationContext.selectedCollection) {
			Section {
				ForEach(appCollections) { collection in
					NavigationLink(collection.name, value: collection)
				}
			}
			
			Section {
				ForEach(personalCollections) { collection in
					NavigationLink(collection.name, value: collection)
				}
				.onDelete(perform: deleteItems)
				Button(action: addItem) {
					Label("Add Collection", systemImage: "plus")
				}
			} header: {
				Label("Collections", systemImage: "photo.stack")
			}
		}
		.listStyle(.insetGrouped)
		.toolbar {
			ToolbarItem(placement: .topBarLeading) {
				Button("", systemImage: "arrow.clockwise") {
					isResetSampleDataPresented.toggle()
				}
			}
			ToolbarItem(placement: .topBarTrailing) {
				EditButton()
			}
		}
		.sheet(isPresented: $isEditorPresented) {
			EditCollectionForm(collection: nil, deleteHandler: nil)
		}
		.alert("Reset sample data?", isPresented: $isResetSampleDataPresented) {
			Button("Yes, reset sample data", role: .destructive) {
				modelContext.resetSampleData()
			}
		} message: {
			Text("You can start with a clean slate by deleting everything and restoring the original sample data.")
		}
	}
}

extension MainOverview {
	private var personalCollections: [LandmarkCollection] {
		collections.filter { collection in
			[
				LandmarkCollection.browse.name,
				LandmarkCollection.favorites.name,
			]
				.contains(collection.name) == false
		}
		.sorted(using: SortDescriptor(\.name, comparator: .localized))
	}
	
	private var appCollections: [LandmarkCollection] {
		collections.filter { collection in
			[
				LandmarkCollection.browse.name,
				LandmarkCollection.favorites.name,
			]
				.contains(collection.name)
		}
		.sorted(using: SortDescriptor(\.name, comparator: .localized))
	}
}

extension MainOverview {
	private func addItem() {
		isEditorPresented.toggle()
	}
	
	private func deleteItems(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				modelContext.delete(personalCollections[index])
			}
		}
	}
}
