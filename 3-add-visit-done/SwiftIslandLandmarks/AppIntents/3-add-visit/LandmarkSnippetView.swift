import SwiftUI
import AppIntents

// We need to add a button that will trigger our intent.
struct LandmarkSnippetView: View {
	let landmark: LandmarkEntity
	
	var body: some View {
		ZStack {
			LinearGradient(colors: [.yellow, .red], startPoint: .top, endPoint: .bottomTrailing)
				.opacity(0.3)
				.clipShape(.containerRelative)
			VStack(alignment: .leading) {
				Text(landmark.name)
					.font(.headline)
					.fontDesign(.rounded)
					.frame(maxWidth: .infinity, alignment: .leading)
				
				if let visit = fetchedLandmark.visits.sorted(by: { $0.timestamp > $1.timestamp }).first {
					HStack {
						VStack(alignment: .leading, spacing: 2) {
							if !visit.log.isEmpty {
								Text(visit.log)
									.lineLimit(3)
									.multilineTextAlignment(.leading)
							}
							Text("Last visit: \(visit.timestamp.formatted(date: .abbreviated, time: .omitted))")
								.font(.caption)
								.fontWeight(.light)
								.frame(maxWidth: .infinity, alignment: .leading)
						}
						Button(
							intent: UpdateFavoriteIntent(landmark: landmark)
						) {
							Image(systemName: landmark.isFavorite ? "star.fill" : "star")
								.contentTransition(.symbolEffect(.replace.magic(fallback: .replace)))
						}
						.tint(.red)
					}
				}
				// 1. Add the button that will call our `AddVisitIntent`.
				Button(
					intent: AddVisitIntent(landmark: landmark)
				) {
					Text("\(Image(systemName: "pin.circle.fill")) Add visit")
				}
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
