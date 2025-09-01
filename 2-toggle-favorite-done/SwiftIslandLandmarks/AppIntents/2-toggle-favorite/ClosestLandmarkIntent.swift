import AppIntents
import SwiftData
import SwiftUI

// Change the returned result in the perform to include a snippet view.
struct ClosestLandmarkIntent: AppIntent {
	
	// 1. We'll be grabbing stuff from the database.
	@Dependency
	var modelContainer: ModelContainer
	
	// 2. Let's add another title and a description.
	static let title: LocalizedStringResource = "Closest Landmark"
	static let description = IntentDescription("Find the closest landmark to you.")
	
	// 3. We'll find the closest landmark to us and announce that we found it.
	//    Note that we need to declare everything we want the result to do
	//    in the return type.
	// 4. Now, we want to show a nice view for the Landmark as well. Add that
	//    to the return type.
	// --
	// 6. Changes here. We now show an intent instead of a view.
	@MainActor
	func perform() async throws -> some IntentResult & ReturnsValue<LandmarkEntity> & ProvidesDialog & ShowsSnippetIntent {
		// 3a. We try to find the closest landmark. For now, we hardcode this to Prins Hendrik.
		let landmarks = try modelContainer.landmarks()
		let closestLandmark = landmarks.first { $0.name.contains("Prins Hendrik") }
		guard let result = closestLandmark else {
			throw ClosestLandmarkError.unableToLocateLandmark
		}
		// 3b. Now, we need to convert the landmark to a proper IntentValue.
		//     We do this by creating an AppEntity called `LandmarkEntity`.
		let landmark = LandmarkEntity(landmark: result, modelContainer: modelContainer)
		
		return .result(
			value: landmark,
			dialog: IntentDialog("The closest landmark is '\(result.name)'"),
			// 5. And we add a new snippet view!
			// --
			// 7. Changes here. We show an intent, not a view.
			snippetIntent: LandmarkSnippetIntent(landmark: landmark)
		)
	}
}

enum ClosestLandmarkError: Error {
	case unableToLocateLandmark
}
