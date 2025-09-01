import AppIntents
import SwiftUI

// Update the view to use the correct values and be able
// to call the app intent to set the log.
struct VisitSnippetView: View {

	// 1. Add the appropriate properties.
	let landmark: LandmarkEntity
	let visit: VisitEntity
	
	var body: some View {
		VStack(alignment: .leading) {
			Text("You visited '\(landmark.name)'!")
				.font(.headline)
				.frame(maxWidth: .infinity, alignment: .leading)
			Text("on \(visit.timestamp.formatted(date: .abbreviated, time: .omitted))")
			Divider()
			Text("Want to add some thoughts?")
				.fontWeight(.bold)
			if !visit.log.isEmpty {
				Text(visit.log)
			}
			// 2. Add a button that will trigger the app intent.
			Button(intent: SetVisitLogSnippetIntent(visit: visit, landmark: landmark)) {
				Text(visit.log.isEmpty ? "Add log" : "Edit log")
			}
		}
	}
	
	private var fetchedVisit: Visit? {
		do {
			let fetchedVisit = try visit.fetchedValue
			return fetchedVisit
		} catch {
			return nil
		}
	}
}
