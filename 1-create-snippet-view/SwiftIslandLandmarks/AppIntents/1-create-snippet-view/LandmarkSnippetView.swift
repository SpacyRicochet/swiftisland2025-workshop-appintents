import SwiftUI
import AppIntents

// We need to add the landmark here somehow
// and make sure it can be passed in future intents.
struct LandmarkSnippetView: View {
	
	var body: some View {
		ZStack {
			LinearGradient(colors: [.yellow, .red], startPoint: .top, endPoint: .bottomTrailing)
				.opacity(0.3)
				.clipShape(.containerRelative)
			HStack {
				Text(DeleteAfter.name)
					.font(.headline)
					.fontDesign(.rounded)
					.frame(maxWidth: .infinity, alignment: .leading)
				Image(systemName: DeleteAfter.isFavorite ? "star.fill" : "star")
					.tint(.red)
			}
			.padding()
		}
	}
}

// Delete this stuff after.
private struct DeleteAfter {
	static let name = "Prins Hendrik"
	static let isFavorite = false
}
