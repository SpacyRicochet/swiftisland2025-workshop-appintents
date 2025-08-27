import AppIntents
import SwiftData

// To allow App Intents to work with our models, we need to make something
// that conforms to `AppEntity`. You could do this directly on your model,
// but it's often useful to keep that separation and create an intermediate
// representation instead.
struct LandmarkEntity: AppEntity {
	
	let modelID: UUID
	let modelContainer: ModelContainer
	
	// You use `@Property` for the properties that the App Intents will interact with.
	// The property's title is derived from the property name.
	@Property
	var name: String
	
	// You can add a property title, if the property name isn't great.
	@Property(title: "Favorite")
	var isFavorite: Bool

	init(landmark: Landmark, modelContainer: ModelContainer) {
		self.modelID = landmark.modelID
		self.modelContainer = modelContainer
		self.name = landmark.name
		self.isFavorite = landmark.isFavorite
	}
	
	// 1. Every AppEntity needs a DisplayRepresentation.
	var displayRepresentation: DisplayRepresentation {
		// We use string interpolation, because it's actually a LocalizedStringResource.
		DisplayRepresentation(title: "\(name)")
	}
	
	// 2. It also needs a name to display the type.
	static var typeDisplayRepresentation: TypeDisplayRepresentation {
		TypeDisplayRepresentation(name: "Landmark")
	}
	
	// 3. Every AppEntity needs a unique, persistant identifier.
	//    You'll notice this is not `Landmark.ID`, which would make more sense.
	//    Sadly, that doesn't conform to all the necessary constraints, so we
	//    fake our way out of this with a different unique identifier.
	var id: UUID { modelID }
	
	// 4. And finally, every AppEntity also needs a default query for the type.
	//    This is the part where you hear a record scratch and go "Wuh?"
	//    Read further down.
	static let defaultQuery = LandmarkEntityQuery()
}

// 5. We can make a small query for now, just to satisfy AppEntity.
struct LandmarkEntityQuery: EntityQuery {
	@Dependency
	var modelContainer: ModelContainer
	
	@MainActor
	func entities(for identifiers: [UUID]) async throws -> [LandmarkEntity] {
		return try modelContainer.landmarks(for: identifiers).map {
			LandmarkEntity(landmark: $0, modelContainer: modelContainer)
		}
	}
}

extension LandmarkEntity {
	
	@MainActor
	var fetchedValue: Landmark {
		get throws {
			guard let result = try modelContainer.landmarks(for: [modelID]).first else {
				throw LandmarkEntityError.couldNotLoadLandmark
			}
			return result
		}
	}
}

enum LandmarkEntityError: Error {
	case couldNotLoadLandmark
}
