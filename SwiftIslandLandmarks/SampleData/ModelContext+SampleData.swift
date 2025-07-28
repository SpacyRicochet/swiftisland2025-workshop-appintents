import SwiftData

extension ModelContext {
	func insertSampleData() {
		for landmark in Landmark.initialList {
			insert(landmark)
		}
		insert(LandmarkCollection.swiftIsland)
	}
}
