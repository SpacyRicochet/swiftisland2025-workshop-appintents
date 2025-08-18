import SwiftUI
import AppIntents

struct LandmarkSnippetView: View {
	let landmark: LandmarkEntity
	
	var body: some View {
		ZStack {
			Color.yellow
			VStack {
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
				.font(.title)
				if !fetchedLandmark.visits.isEmpty {
					Text("Visits")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.headline)
					Divider()
					ForEach(fetchedLandmark.visits) { visit in
						VStack(alignment: .leading) {
							Text(visit.timestamp.formatted(date: .abbreviated, time: .shortened))
								.font(.caption)
							Text(visit.log.prefix(50) + "…")
								.frame(maxWidth: .infinity, alignment: .leading)
						}
						.padding()
						.background(.gray, in: RoundedRectangle(cornerRadius: 2, style: .continuous))
					}
				}
			}
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
