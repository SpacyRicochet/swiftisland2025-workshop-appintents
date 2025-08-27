import AppIntents
import SwiftUI

// Connect to your entities and add a button that triggers the next intent.

struct VisitSnippetView: View {

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
		}
	}
}

private enum DeleteAfter {
	static let landmarkName = "Prins Hendrik"
	static let visitTimestamp = Date()
	static let visitLog = "Hello, world!"
}
