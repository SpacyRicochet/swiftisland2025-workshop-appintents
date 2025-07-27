import SwiftData

extension Schema {
	static var allEntities = Schema([
		AppContext.self,
		Coordinates.self,
		Landmark.self,
	])
}
