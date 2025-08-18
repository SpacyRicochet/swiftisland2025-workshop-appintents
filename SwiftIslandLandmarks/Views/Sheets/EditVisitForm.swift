import SwiftData
import SwiftUI

struct EditVisitForm: View {
	@Environment(\.modelContext) private var modelContext
	@Environment(\.dismiss) private var dismiss
	
	let landmark: Landmark
	let visit: Visit?
	let deleteHandler: (() -> Void)?
	
	@State private var isDeleteConfirmationPresented: Bool = false
	@State private var timestamp: Date = Date()
	@State private var log: String = ""
	
	var body: some View {
		NavigationStack {
			Group {
				if visit != nil {
					form
						.navigationTitle("Edit visit")
						.alert("Delete this visit", isPresented: $isDeleteConfirmationPresented) {
							Button("Cancel", role: .cancel) { }
							Button("Delete", role: .destructive) {
								delete()
							}
						}
				} else {
					form
						.navigationTitle("Add visit")
				}
			}
			.onAppear() {
				if let visit {
					timestamp = visit.timestamp
					log = visit.log
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
				if visit != nil {
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
			Section(header: Text("Date and time")) {
				DatePicker(
					"Date & Time",
					selection: $timestamp,
					displayedComponents: [.date, .hourAndMinute]
				)
			}
			Section(header: Text("Log")) {
				TextEditor(text: $log)
					.frame(minHeight: 142)
			}
		}
	}
}

extension EditVisitForm {
	func save() {
		if let visit {
			visit.log = log
		} else {
			let visit = Visit(
				timestamp: timestamp,
				log: log
			)
			modelContext.insert(visit)
			landmark.visits.append(visit)
		}
		dismiss()
	}
	
	func confirmDeletion() {
		isDeleteConfirmationPresented = true
	}
	
	func delete() {
		guard let visit else { return }
		landmark.visits.removeAll { $0.id == visit.id }
		dismiss()
		deleteHandler?()
	}
}
