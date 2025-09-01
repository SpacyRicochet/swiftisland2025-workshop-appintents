import SwiftUI
import AppIntents

// We need to add the landmark here somehow
// and make sure it can be passed in future intents.
struct LandmarkSnippetView: View {
	// 1. We add the landmark entity as a property.
	let landmark: LandmarkEntity
	
	var body: some View {
		ZStack {
			LinearGradient(colors: [.yellow, .red], startPoint: .top, endPoint: .bottomTrailing)
				.opacity(0.3)
				.clipShape(.containerRelative)
			HStack {
				// And use its properties below.
				Text(landmark.name)
					.font(.headline)
					.fontDesign(.rounded)
					.frame(maxWidth: .infinity, alignment: .leading)				
				Image(systemName: landmark.isFavorite ? "star.fill" : "star")
					.tint(.red)
			}
			.padding()
		}
	}
}
