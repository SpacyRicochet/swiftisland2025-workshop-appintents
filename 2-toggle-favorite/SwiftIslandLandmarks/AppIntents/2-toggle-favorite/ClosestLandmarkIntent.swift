import AppIntents
import SwiftData
import SwiftUI

// Change the returned result in the perform to include a snippet view.
struct ClosestLandmarkIntent: AppIntent {
	
	@Dependency
	var modelContainer: ModelContainer
	
	static let title: LocalizedStringResource = "Closest Landmark"
	static let description = IntentDescription("Find the closest landmark to you.")
	
	@MainActor
	func perform() async throws -> some IntentResult & ReturnsValue<LandmarkEntity> & ProvidesDialog & ShowsSnippetView {
		let landmarks = try modelContainer.landmarks()
		let closestLandmark = landmarks.first { $0.name.contains("Prins Hendrik") }
		guard let result = closestLandmark else {
			throw ClosestLandmarkError.unableToLocateLandmark
		}
		let landmark = LandmarkEntity(landmark: result, modelContainer: modelContainer)
		
		return .result(
			value: landmark,
			dialog: IntentDialog("The closest landmark is '\(result.name)'"),
			view: LandmarkSnippetView(landmark: landmark)
		)
	}
}

enum ClosestLandmarkError: Error {
	case unableToLocateLandmark
}
