import AppIntents
import SwiftData

// Like Landmark, we want to work with Visits in our App Intents.
// So we need to make a similar VisitEntity, that allows us to pass
// it around as an `@Parameter`.

//struct VisitEntity: AppEntity {
//	
//}

// Just like before, we'll make a small query to satisfy App Intents.

//struct VisitEntityQuery: EntityQuery {
//	@Dependency
//	var modelContainer: ModelContainer
//	
//	@MainActor
//	func entities(for identifiers: [UUID]) async throws -> [VisitEntity] {
//		return try modelContainer.visits(for: identifiers).map {
//			VisitEntity(visit: $0, modelContainer: modelContainer)
//		}
//	}
//}
