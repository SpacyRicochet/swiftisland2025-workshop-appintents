import AppIntents
import SwiftData

// To allow App Intents to work with our models, we need to make something
// that conforms to `AppEntity`. You could do this directly on your model,
// but it's often useful to keep that separation and create an intermediate
// representation instead.

//struct LandmarkEntity: AppEntity {
//
//}

//struct LandmarkEntityQuery: EntityQuery {
//	@Dependency
//	var modelContainer: ModelContainer
//	
//	@MainActor
//	func entities(for identifiers: [UUID]) async throws -> [LandmarkEntity] {
//		return try modelContainer.landmarks(for: identifiers).map {
//			LandmarkEntity(landmark: $0)
//		}
//	}
//}
