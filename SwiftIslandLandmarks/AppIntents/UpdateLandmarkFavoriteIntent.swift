import AppIntents
import SwiftData

// We have to create an intent, for the sole purpose of updating the favorite status on a landmark.
struct UpdateLandmarkFavoriteIntent: AppIntent {
	// 1. Title and description again.
	static let title: LocalizedStringResource = "Update Landmark Favorite"
	static let description = IntentDescription("Set or remove the favorite status from a landmark.")
	
	// 2. We set the necessary parameters and dependencies again.
	@Parameter
	var landmark: LandmarkEntity
	@Dependency
	var modelContainer: ModelContainer
	
	// 3. In this perform function, we need to return the _updated_ landmark.
	@MainActor
	func perform() async throws -> some IntentResult & ReturnsValue<LandmarkEntity> {
		let fetchedLandmark = try landmark.fetchedValue
		// 4. We toggle the favorite status on the landmark and create an updated entity to pass back.
		fetchedLandmark.isFavorite.toggle()
		let result = LandmarkEntity(landmark: fetchedLandmark, modelContainer: modelContainer)
		
		// 5. Now, we only need to return newly updated landmark and the snippet will pick that up.
		return .result(
			value: result
		)
	}
}

extension UpdateLandmarkFavoriteIntent {
	// 6. We need to declare another initializer in an extension, because the `init()` is
	//    required. But we also need a parametrized version for our snippet to call.
	init(landmark: LandmarkEntity) {
		self.landmark = landmark
	}
}
