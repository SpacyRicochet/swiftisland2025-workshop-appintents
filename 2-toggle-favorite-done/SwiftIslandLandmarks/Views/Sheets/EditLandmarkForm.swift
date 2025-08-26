import SwiftData
import SwiftUI

struct EditLandmarkForm: View {
	@Environment(\.modelContext) private var modelContext
	@Environment(\.dismiss) private var dismiss
	
	let landmark: Landmark?
	let deleteHandler: (() -> Void)?
	
	@State private var isDeleteConfirmationPresented: Bool = false
	@State private var name: String = ""
	
	var body: some View {
		NavigationStack {
			Group {
				if let landmark {
					form
						.navigationTitle("Edit \(landmark.name)")
						.alert("Delete \(landmark.name)", isPresented: $isDeleteConfirmationPresented) {
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
				if let landmark {
					name = landmark.name
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
				if landmark != nil {
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

extension EditLandmarkForm {
	func save() {
		if let landmark {
			landmark.name = name
		} else {
			let landmark = Landmark(
				name: name,
				latitude: Landmark.texel.latitude,
				longitude: Landmark.texel.longitude,
				isFavorite: false,
				lastVisited: nil
			)
			modelContext.insert(landmark)
		}
		dismiss()
	}
	
	func confirmDeletion() {
		isDeleteConfirmationPresented = true
	}
	
	func delete() {
		guard let landmark else { return }
		modelContext.delete(landmark)
		dismiss()
		deleteHandler?()
	}
}
