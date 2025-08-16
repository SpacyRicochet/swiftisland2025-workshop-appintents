import SwiftUI
import AppIntents

struct LandmarkSnippetView: View {
	let landmark: LandmarkEntity
	
	var body: some View {
		ZStack {
			Color.yellow
			HStack {
				Text(landmark.name)
					.font(.headline)
					.frame(maxWidth: .infinity, alignment: .leading)
				Button(
					intent: UpdateLandmarkFavoriteIntent(landmark: landmark)
				) {
					Image(systemName: landmark.isFavorite ? "star.fill" : "star")
						.contentTransition(.symbolEffect(.replace.magic(fallback: .replace)))
				}
			}
			.font(.headline)
		}
	}
}
