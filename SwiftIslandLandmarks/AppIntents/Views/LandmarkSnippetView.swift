import SwiftUI

struct LandmarkSnippetView: View {
	let landmark: LandmarkEntity
	
	var body: some View {
		ZStack {
			Color.yellow
			HStack {
				Text(landmark.name)
					.font(.headline)
					.frame(maxWidth: .infinity, alignment: .leading)
				Image(systemName: landmark.isFavorite ? "star.fill" : "star")
			}
		}
	}
}
