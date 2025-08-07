import SwiftData

extension Schema {
	static var allEntities = Schema([
		AppContext.self,
		Landmark.self,
		LandmarkCollection.self,
		Visit.self,
	])
}
