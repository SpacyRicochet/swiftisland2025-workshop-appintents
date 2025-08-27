import SwiftUI
import AppIntents

struct LandmarkSnippetView: View {
	let landmark: LandmarkEntity
	
	var body: some View {
		ZStack {
			LinearGradient(colors: [.yellow, .red], startPoint: .top, endPoint: .bottomTrailing)
				.opacity(0.3)
				.clipShape(.containerRelative)
			HStack {
				Text(landmark.name)
					.font(.headline)
					.fontDesign(.rounded)
					.frame(maxWidth: .infinity, alignment: .leading)
				Button(
					intent: UpdateFavoriteIntent(landmark: landmark)
				) {
					Image(systemName: landmark.isFavorite ? "star.fill" : "star")
						.contentTransition(.symbolEffect(.replace.magic(fallback: .replace)))
				}
				.tint(.red)
			}
			.padding()
		}
	}
	
	private var fetchedLandmark: Landmark {
		do {
			return try landmark.fetchedValue
		} catch {
			fatalError("Error while retrieving landmark; \(error.localizedDescription)")
		}
	}
}
