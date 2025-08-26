import SwiftData
import SwiftUI

struct EditCollectionForm: View {
	@Environment(\.modelContext) private var modelContext
	@Environment(\.dismiss) private var dismiss
	
	let collection: LandmarkCollection?
	let deleteHandler: (() -> Void)?
	
	@State private var isDeleteConfirmationPresented: Bool = false
	@State private var name: String = ""
	
	var body: some View {
		NavigationStack {
			Group {
				if let collection {
					form
						.navigationTitle("Edit \(collection.name)")
						.alert("Delete \(collection.name)", isPresented: $isDeleteConfirmationPresented) {
							Button("Cancel", role: .cancel) { }
							Button("Delete", role: .destructive) {
								delete()
							}
						}
				} else {
					form
						.navigationTitle("Add landmark")
				}
			}
			.onAppear() {
				if let collection {
					name = collection.name
				}
			}
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel", role: .cancel) {
						dismiss()
					}
				}
				ToolbarItem(placement: .confirmationAction) {
					Button("Save", role: .confirm) {
						save()
					}
				}
				if collection != nil {
					ToolbarItem(placement: .destructiveAction) {
						Button("Delete", role: .destructive) {
							confirmDeletion()
						}
					}
				}
			}
		}
	}
	
	var form: some View {
		Form {
			Section(header: Text("Name")) {
				TextField("Name", text: $name)
			}
		}
	}
}

extension EditCollectionForm {
	func save() {
		if let collection {
			collection.name = name
		} else {
			let collection = LandmarkCollection(
				name: name,
				landmarks: []
			)
			modelContext.insert(collection)
		}
		dismiss()
	}
	
	func confirmDeletion() {
		isDeleteConfirmationPresented = true
	}
	
	func delete() {
		guard let collection else { return }
		modelContext.delete(collection)
		dismiss()
		deleteHandler?()
	}
}
