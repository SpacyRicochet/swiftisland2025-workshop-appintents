import Foundation
import SwiftData

extension ModelContainer {
	@MainActor
	func landmark(for id: Landmark.ID) throws -> Landmark {
		guard let result = mainContext.model(for: id) as? Landmark else {
			throw DatabaseError.couldNotFindLandmarkWithID(id)
		}
		return result
	}
}

enum DatabaseError: Error {
	case couldNotFindLandmarkWithID(Landmark.ID)
}
