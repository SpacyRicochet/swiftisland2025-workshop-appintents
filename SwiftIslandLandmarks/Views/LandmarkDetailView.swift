import SwiftUI
import SwiftData

struct LandmarkDetailView: View {
	let landmark: Landmark
	
	var body: some View {
		VStack {
			HStack {
				Text(landmark.name)
					.font(.title)
					.frame(maxWidth: .infinity, alignment: .leading)
				Button {
					landmark.isFavorite.toggle()
				} label: {
					Image(systemName: landmark.isFavorite ? "heart.fill" : "heart")
						.foregroundStyle(.red)
				}
			}
			if let lastVisited = landmark.lastVisited {
				VStack(spacing: 4) {
					Text("Last visited")
					Text(lastVisited.formatted(date: .abbreviated, time: .omitted))
				}
			} else {
				Button {
					landmark.lastVisited = Date()
				} label: {
					Text("Add a visit")
				}
			}
		}
	}
}
