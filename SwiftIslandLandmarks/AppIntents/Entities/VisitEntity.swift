import AppIntents
import SwiftData

// Like Landmark, we want to work with Visits in our App Intents.
// So we need to make a similar VisitEntity, that allows us to pass
// it around as an `@Parameter`.
struct VisitEntity: AppEntity {
	
	// 1. We'll perform the `modelID` trick to appease SwiftData again,
	//    and make sure we can fetch it throug the model container.
	let modelID: UUID
	let modelContainer: ModelContainer
	
	// 2. We'll create `@Parameter` properties to be able to populate
	//    our view.
	@Property
	var timestamp: Date
	@Property
	var log: String
	
	init(visit: Visit, modelContainer: ModelContainer) {
		self.modelID = visit.modelID
		self.modelContainer = modelContainer
		self.timestamp = visit.timestamp
		self.log = visit.log
	}
	
	// 3. We'll add the required display string for the entity.
	var displayRepresentation: DisplayRepresentation {
		DisplayRepresentation(title: "Your visit at \(timestamp.formatted(date: .abbreviated, time: .omitted))")
	}
	
	// 4. And the entity's type name.
	static var typeDisplayRepresentation: TypeDisplayRepresentation {
		TypeDisplayRepresentation(name: "Visit")
	}
	
	// 1a. We'll adopt this for as the identifier.
	var id: UUID { modelID }
	
	// 5. And we create another query, so the system can fetch all
	//    the visits when necessary.
	static let defaultQuery = VisitEntityQuery()
}

// 5a. Just like before, we'll make a small query to satisfy App Intents.
struct VisitEntityQuery: EntityQuery {
	@Dependency
	var modelContainer: ModelContainer
	
	@MainActor
	func entities(for identifiers: [UUID]) async throws -> [VisitEntity] {
		return try modelContainer.visits(for: identifiers).map {
			VisitEntity(visit: $0, modelContainer: modelContainer)
		}
	}
}

extension VisitEntity {
	
	@MainActor
	var fetchedValue: Visit {
		get throws {
			guard let result = try modelContainer.visits(for: [modelID]).first else {
				throw VisitEntityError.couldNotLoadVisit
			}
			return result
		}
	}
}

enum VisitEntityError: Error {
	case couldNotLoadVisit
}
