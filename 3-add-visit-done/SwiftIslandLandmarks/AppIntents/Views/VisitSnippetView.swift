import AppIntents
import SwiftUI

struct VisitSnippetView: View {
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
			// We add a button that will trigger the app intent that sets the visit's log.
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
