import AppIntents
import SwiftUI

// Update the view to use the correct values and be able
// to call the app intent to set the log.
struct VisitSnippetView: View {

	// 1. Add the appropriate properties.

	var body: some View {
		VStack(alignment: .leading) {
			Text("You visited '\(DeleteAfter.landmarkName)'!")
				.font(.headline)
				.frame(maxWidth: .infinity, alignment: .leading)
			Text("on \(DeleteAfter.visitTimestamp.formatted(date: .abbreviated, time: .omitted))")
			Divider()
			Text("Want to add some thoughts?")
				.fontWeight(.bold)
			if !DeleteAfter.visitLog.isEmpty {
				Text(DeleteAfter.visitLog)
			}

			// 2. Add a button that will trigger the app intent.
		}
	}
}

// Delete this afterwards.
private enum DeleteAfter {
	static let landmarkName = "Prins Hendrik"
	static let visitTimestamp = Date()
	static let visitLog = "Hello, world!"
}
